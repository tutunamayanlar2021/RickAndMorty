import UIKit
class SeriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var seriesImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func layoutSubviews() {
           super.layoutSubviews()
           
        // Hücrenin görünümünü özelleştirme
               layer.cornerRadius = 5
               layer.masksToBounds = true
               layer.borderWidth = 1
               layer.borderColor = UIColor.lightGray.cgColor
               
       }
    func setup(with series: Series) {
        titleLbl.text = series.name
        
        series.downloadImage { [weak self] image in
            DispatchQueue.main.async {
                self?.seriesImageView.image = image
                
            }
        }
    }
}
