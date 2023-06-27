import Foundation
import UIKit

struct Series: Codable {
    let name: String
    let image: String
    let status: String
    let species: String
    let gender: String
    let origin: Origin
    let location: Location
    let episode: [String]


    
    func downloadImage(completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: image) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error downloading image: \(error)")
                completion(nil)
                
                return
                
            }
            
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
}

struct APIResponse: Codable {
    let results: [Series]

}
struct Origin: Codable {
    let name: String
}


struct Location: Codable {
    let name: String
    let url: String
}
