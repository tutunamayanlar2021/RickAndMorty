import UIKit
class SeriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var seriesImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 5
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor

    }
    func setup(with series: Series) {
        titleLbl.text = series.name
        titleLbl.textColor = .darkText
        titleLbl.font = UIFont(name: "Arial", size: 16)
        
        
        series.downloadImage { [weak self] image in
            DispatchQueue.main.async {
                self?.seriesImageView.image = image
                
            }
        }
        
    }
}
