//
//  SecondViewController.swift
//  RickAndMorty
//
//  Created by Kader Oral on 26.06.2023.
//

import UIKit

class SecondViewController: UIViewController {
    
    var name = "name"
    var imageUrl = "imageURL"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 2)
        view.addSubview(imageView)
        
        let label = UILabel()
        label.text = name
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: imageView.frame.maxY, width: view.frame.width, height: 50)
        view.addSubview(label)
        
        DispatchQueue.global().async {
            if let url = URL(string: self.imageUrl), let imageData = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: imageData)
                }
            }
        }
       
    }
}
