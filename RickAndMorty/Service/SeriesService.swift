import Foundation

protocol SeriesServiceDelegate: AnyObject {
    func didFetchSeries(_ series: [Series])
    func didFailWithError(_ error: Error)
}

class SeriesService {
    
    weak var delegate: SeriesServiceDelegate?
    
    func fetchSeriesData() {
        let urlString = "https://rickandmortyapi.com/api/character"
        
        if let url = URL(string: urlString) {
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
                    
                    self?.delegate?.didFetchSeries(seriesWithDetails)
                } catch {
                    self?.delegate?.didFailWithError(error)
                }
            }
            
            task.resume()
        } else {
            self.delegate?.didFailWithError(ServiceError.invalidURL)
        }
    }
}

enum ServiceError: Error {
    case noDataReceived
    case invalidURL
}
