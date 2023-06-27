//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Kader Oral on 26.06.2023.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    var name: String?
    var imageUrl : String?
    var status: String?
    var species: String?
    var gender: String?
    var origin: String?
    var location: String?
    var episode: [String?] = []
    @IBOutlet weak var characterImage: UIImageView!
    
    @IBOutlet weak var characterTitle: UILabel!
    
    
    @IBAction func backButton(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        DispatchQueue.global().async {
            if let url = URL(string: self.imageUrl ?? "https://media.istockphoto.com/id/1216251206/vector/no-image-available-icon.jpg?s=170667a&w=0&k=20&c=N-XIIeLlhUpm2ZO2uGls-pcVsZ2FTwTxZepwZe4DuE4="), let imageData = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.characterImage.image = UIImage(data: imageData)
                }
            }
        }
        characterTitle.text = name ?? "isimsiz"
        // Do any additional setup after loading the view.
    }
    
    private func getEpisodeNumbers() -> [String] {
        var episodeNumbers: [String] = []
        for episodeUrl in episode {
            if let url = episodeUrl, let episodeNumber = url.split(separator: "/").last {
                episodeNumbers.append(String(episodeNumber))
            }
        }
        return episodeNumbers
    }

}

extension CharacterDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as! CustomTableViewCell
        var cellText: String?
            
        switch indexPath.row {
                    case 0:
                        cellText = "Status: \(status ?? "")"
                    case 1:
                        cellText = "Species: \(species ?? "")"
                    case 2:
                        cellText = "Gender: \(gender ?? "")"
                    case 3:
                        cellText = "Origin: \(origin ?? "")"
                    case 4:
                        cellText = "Location: \(location ?? "")"
                case 5:
                    // Handle episode data
                    let episodeNumbers = getEpisodeNumbers()
                    let episodeText = episodeNumbers.joined(separator: ", ")
                    cellText = "Episode: \(episodeText)"
                default:
                    break
                }
            
            cell.configure(with: cellText)
 
            return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
       return  44.0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }

}
