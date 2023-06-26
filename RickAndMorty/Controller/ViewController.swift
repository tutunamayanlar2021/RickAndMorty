import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var series: [Series] = []
    let seriesService = SeriesService()
    var destinationVC = CharacterDetailViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        
        seriesService.delegate = self
        seriesService.fetchSeriesData()
    }
    
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return series.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeriesCollectionViewCell", for: indexPath) as! SeriesCollectionViewCell
        let seriesItem = series[indexPath.row]
        cell.setup(with: seriesItem)
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2 - 10, height: 250)
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail",
           let indexPath = sender as? IndexPath,
           let destinationVC = segue.destination as? CharacterDetailViewController {
            let selectedSeries = series[indexPath.row]
            destinationVC.name = selectedSeries.name
            destinationVC.imageUrl = selectedSeries.image
        }
    }
}



extension ViewController: SeriesServiceDelegate {
    func didFetchSeries(_ series: [Series]) {
        self.series = series
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func didFailWithError(_ error: Error) {
        print("Error fetching series data: \(error)")
    }
}
