import Foundation
import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, RouterProtocol {
    
    var favoritePictures: [PictureModel] = []
    
    var tabBarSet = false
    
    let idCustomCell = "idCustomCell"
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var tabBarHeight: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.tableView.register(FavoriteCell.self, forCellReuseIdentifier: idCustomCell)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.tabBarSet == false {
            self.constraintsForTableView()
            self.tabBarSet = true
        }
        self.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.favoritePictures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: idCustomCell, for: indexPath) as? FavoriteCell else {
            return UITableViewCell()
        }
        let model = self.favoritePictures[indexPath.row]
        cell.configureCell(pictureModel: model)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        let pictureModel = self.favoritePictures[indexPath.row]
        detailViewController.configure(pictureModel: pictureModel, delegate: self)
        self.present(detailViewController, animated: true)
    }
    
    func reloadData() {
        self.favoritePictures = FavoritePicturesService.shared.getFavoritePictures()
        self.tableView.reloadData()
    }
    
    func showAlert() {}
    
    func setTabBarHeight(height: CGFloat) {
        self.tabBarHeight = height
    }
    
    func constraintsForTableView() {
        self.view.addSubview(tableView)
        guard let tabBarHeight = self.tabBarHeight else {
            return
        }
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -tabBarHeight),
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 90)
        ])
    }
}
