import UIKit

class DetailViewController: UIViewController {
    
    var picture: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var authorName = LabelFactory.standart
    
    var location = LabelFactory.standart
    
    var likes = LabelFactory.standartRight
    
    var createDate = LabelFactory.standart
    
    var favoriteButton: UIButton = {
        let button = UIButton()
        button.setTitle("🤍", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(favoriteButtonTap), for: .touchUpInside)
        return button
    }()
    
    var favoritePicturesService = FavoritePicturesService.shared
    
    var pictureModel: PictureModel?
    
    var delegate: RouterProtocol?
    
    var widthLabel: CGFloat = 0
    
    var offSet: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSheetPresentation()
        self.view.backgroundColor = .white
        self.offSet = 24
        self.widthLabel = self.view.frame.width/2 - self.offSet
        self.constraintsForPicture()
        self.constraintsForAuthorName()
        self.constraintsForCreateData()
        self.constraintsForLocation()
        self.constraintsForLikes()
        self.constraintsForFavoriteButton()
    }
    
    @objc func favoriteButtonTap() {
        guard let model = self.pictureModel else { return }
        model.isFavorite.toggle()
        if model.isFavorite {
            favoritePicturesService.addFavoritePicture(pictureModel: model)
        } else {
            favoritePicturesService.removeFavoritePicture(pictureModel: model)
        }
        self.checkIsFavorite(favorite: model.isFavorite)
        self.delegate?.reloadData()
    }
    
    func checkIsFavorite(favorite: Bool) {
        if favorite {
            self.favoriteButton.setTitle("❤️", for: .normal)
        } else {
            self.favoriteButton.setTitle("🤍", for: .normal)
        }
    }
    
    func configure(pictureModel: PictureModel, delegate: RouterProtocol?) {
        self.delegate = delegate
        let isFavorite = favoritePicturesService.ifIsFavorite(pictureModel: pictureModel)
        self.checkIsFavorite(favorite: isFavorite)
        self.pictureModel = pictureModel
        self.picture.image = pictureModel.picture
        self.authorName.text = "✍️ " + pictureModel.authorName
        self.createDate.text = "🗓 " + pictureModel.createDate
        self.location.text = "📍 " + pictureModel.location
        self.likes.text = pictureModel.likes + " 👍"
    }
    
    private func setupSheetPresentation() {
        self.sheetPresentationController?.detents = [.medium()]
        self.sheetPresentationController?.prefersScrollingExpandsWhenScrolledToEdge = false
        self.sheetPresentationController?.prefersGrabberVisible = true
        self.sheetPresentationController?.preferredCornerRadius = 20
    }
    
    func constraintsForPicture() {
        self.view.addSubview(picture)
        NSLayoutConstraint.activate([
            picture.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0.7*self.offSet),
            picture.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: self.offSet),
            picture.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -self.offSet),
            picture.heightAnchor.constraint(equalTo: self.view.widthAnchor, constant: -5.5*self.offSet)
            ])
    }
    
    func constraintsForAuthorName() {
        self.view.addSubview(authorName)
        NSLayoutConstraint.activate([
            authorName.topAnchor.constraint(equalTo: self.picture.bottomAnchor, constant: 8),
            authorName.leadingAnchor.constraint(equalTo: self.picture.leadingAnchor),
            authorName.heightAnchor.constraint(equalToConstant: 24),
            authorName.widthAnchor.constraint(equalToConstant: self.widthLabel)
            ])
    }
    
    func constraintsForCreateData() {
        self.view.addSubview(createDate)
        NSLayoutConstraint.activate([
            createDate.topAnchor.constraint(equalTo: self.authorName.bottomAnchor),
            createDate.leadingAnchor.constraint(equalTo: self.authorName.leadingAnchor),
            createDate.heightAnchor.constraint(equalToConstant: 24),
            createDate.widthAnchor.constraint(equalToConstant: self.widthLabel)
            ])
    }

    func constraintsForLocation() {
        self.view.addSubview(location)
        NSLayoutConstraint.activate([
            location.topAnchor.constraint(equalTo: self.createDate.bottomAnchor),
            location.leadingAnchor.constraint(equalTo: self.createDate.leadingAnchor),
            location.trailingAnchor.constraint(equalTo: self.picture.trailingAnchor),
            location.heightAnchor.constraint(equalToConstant: 24)
            ])
    }
    
    func constraintsForLikes() {
        self.view.addSubview(likes)
        NSLayoutConstraint.activate([
            likes.topAnchor.constraint(equalTo: self.picture.bottomAnchor, constant: 8),
            likes.trailingAnchor.constraint(equalTo: self.picture.trailingAnchor),
            likes.heightAnchor.constraint(equalToConstant: 24),
            likes.widthAnchor.constraint(equalToConstant: self.widthLabel)
            ])
    }
    
    func constraintsForFavoriteButton() {
        self.view.addSubview(favoriteButton)
        NSLayoutConstraint.activate([
            favoriteButton.bottomAnchor.constraint(equalTo: self.picture.bottomAnchor, constant: -8),
            favoriteButton.trailingAnchor.constraint(equalTo: self.picture.trailingAnchor, constant: -8),
            favoriteButton.heightAnchor.constraint(equalToConstant: 50),
            favoriteButton.widthAnchor.constraint(equalToConstant: 50)
            ])
    }

}
