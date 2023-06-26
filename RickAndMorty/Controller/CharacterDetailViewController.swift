//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Kader Oral on 26.06.2023.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    var name: String?
    var imageUrl = ""
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
            if let url = URL(string: self.imageUrl), let imageData = try? Data(contentsOf: url) {
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
