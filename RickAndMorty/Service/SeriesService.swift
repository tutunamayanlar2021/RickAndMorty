import Foundation
import Network

protocol SeriesServiceDelegate: AnyObject {
    func didFetchSeries(_ series: [Series])
    func didFailWithError(_ error: Error)
}

class SeriesService {
    weak var delegate: SeriesServiceDelegate?
    
    private let urlString = "https://rickandmortyapi.com/api/character"
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    private var hasFetchedDataFromAPI = false
    
    func fetchSeriesData() {
        if let localData = LocalDataProvider.shared.getSeriesData() {
            delegate?.didFetchSeries(localData)
        } else if !hasFetchedDataFromAPI {
            fetchSeriesDataFromAPI()
        }
    }
    
    private func fetchSeriesDataFromAPI() {
        guard let url = URL(string: urlString) else {
            self.delegate?.didFailWithError(ServiceError.invalidURL)
            
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                self?.delegate?.didFailWithError(error)
                return
            }
            
            guard let data = data else {
                self?.delegate?.didFailWithError(ServiceError.noDataReceived)
                return
            }
            
            do {
                let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                
                let seriesWithDetails = apiResponse.results.map { series in
                    return Series(name: series.name,
                                  image: series.image,
                                  status: series.status,
                                  species: series.species,
                                  gender: series.gender,
                                  origin: series.origin,
                                  location: series.location,
                                  episode: series.episode
                    )
                    
                }
                
                self?.saveSeriesDataLocally(seriesWithDetails)
                self?.delegate?.didFetchSeries(seriesWithDetails)
                self?.hasFetchedDataFromAPI = true
                print(self?.hasFetchedDataFromAPI ?? "")
            } catch {
                self?.delegate?.didFailWithError(error)
            }
        }
        
        task.resume()
    }
    
    private func saveSeriesDataLocally(_ series: [Series]) {
        LocalDataProvider.shared.setSeriesData(series)
    }
}

enum ServiceError: Error {
    case noDataReceived
    case invalidURL
    case noInternetConnection
}
