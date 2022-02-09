import Foundation
import UIKit
import BouncyLayout

class GalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, RouterProtocol {
    
    var pictureModels: [PictureModel] = []
    
    var tabBarSet = false
    
    private var collectionView : UICollectionView?
    
    var networkService: NetworkService?
    
    let searchBar = UISearchBar()
    
    var tabBarHeight: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        self.searchBar.backgroundImage = UIImage()
        self.view.backgroundColor = .white
        let layout = self.createCollectionViewLayout()
        self.createCollectionView(collectionViewFlowLayout: layout)
        self.collectionView?.delegate = self
        self.networkService = NetworkService.shared
        self.networkService?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.tabBarSet == false {
            self.contraintsForSearchBar()
            self.contraintsForCollectionView()
            self.tabBarSet = true
        }
    }
    
    private func createCollectionViewLayout() -> UICollectionViewFlowLayout {
        let collectionViewFlowLayout = BouncyLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumInteritemSpacing = 0
        collectionViewFlowLayout.minimumLineSpacing = 0
        collectionViewFlowLayout.itemSize = CGSize(width: self.view.frame.width/3, height: self.view.frame.width/3)
        return collectionViewFlowLayout
    }
    
    private func createCollectionView(collectionViewFlowLayout: UICollectionViewFlowLayout) {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.identifier)
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        self.collectionView = collectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictureModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as? ImageCell else {
            return UICollectionViewCell()
        }
        let model = self.pictureModels[indexPath.row]
        let image = model.picture
        cell.configureWithImage(image: image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        let pictureModel = self.pictureModels[indexPath.row]
        detailViewController.configure(pictureModel: pictureModel, delegate: self)
        self.present(detailViewController, animated: true)
    }
    
    func reloadData() {
        guard let networkService = networkService else { return }
        self.pictureModels = networkService.getPictureModels()
        self.collectionView?.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        if let text = searchBar.text {
            self.collectionView?.reloadData()
            self.networkService?.urlStringWithText(text: text)
        }
    }
    
    func showAlert() {
        let alertController = UIAlertController.init(title: "Try another request", message: nil, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            alertController.dismiss(animated: true, completion: nil)
        }
    }
    
    func setTabBarHeight(height: CGFloat) {
        self.tabBarHeight = height
    }
    
    func contraintsForCollectionView() {
        guard let collectionView = self.collectionView else {
            return
        }
        guard let tabBarHeight = self.tabBarHeight else {
            return
        }
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -tabBarHeight),
            collectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor)
            ])
    }
    
    func contraintsForSearchBar() {
        self.view.addSubview(searchBar)
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            searchBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40)
            ])
    }
}
