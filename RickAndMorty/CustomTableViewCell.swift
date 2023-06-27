//
//  CustomTableViewCell.swift
//  RickAndMorty
//
//  Created by Kader Oral on 27.06.2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var tableLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        tableLabel.numberOfLines = 0
        tableLabel.lineBreakMode = .byWordWrapping
        tableLabel.translatesAutoresizingMaskIntoConstraints = false
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(with cellText: String?) {
        tableLabel.text = cellText
     
}
    

}
