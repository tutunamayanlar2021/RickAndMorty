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
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little //preparation before navigation
    
    
    
}
