import UIKit

class FavoriteCell: UITableViewCell {
    
    var cellTitle = LabelFactory.standartRight
    
    var cellPicture: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var cellContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.setConstraintsCellContainer()
        self.setConstraintsCellPicture()
        self.setConstraintsCellTitle()
    }
    
    func configureCell(pictureModel: PictureModel) {
        self.selectionStyle = .none
        self.cellPicture.image = pictureModel.picture
        self.cellTitle.text = pictureModel.authorName + "   ✍️"
    }
        
    func setConstraintsCellContainer() {
        self.addSubview(cellContainer)
        NSLayoutConstraint.activate([
            cellContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            cellContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            cellContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            cellContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
            ])
    }
    
    func setConstraintsCellTitle() {
        self.cellContainer.addSubview(cellTitle)
        NSLayoutConstraint.activate([
            cellTitle.centerYAnchor.constraint(equalTo: self.cellPicture.centerYAnchor),
            cellTitle.leadingAnchor.constraint(equalTo: self.cellPicture.trailingAnchor, constant: 16),
            cellTitle.trailingAnchor.constraint(equalTo: self.cellContainer.trailingAnchor, constant: -16),
            cellTitle.heightAnchor.constraint(equalToConstant: 28)
            ])
    }
    
    func setConstraintsCellPicture() {
        self.cellContainer.addSubview(cellPicture)
        NSLayoutConstraint.activate([
            cellPicture.widthAnchor.constraint(equalToConstant: 60),
            cellPicture.heightAnchor.constraint(equalToConstant: 60),
            cellPicture.leadingAnchor.constraint(equalTo: self.cellContainer.leadingAnchor, constant: 16),
            cellPicture.topAnchor.constraint(equalTo: self.cellContainer.topAnchor, constant: 11)
            ])
    }
    
}
