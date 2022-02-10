import Foundation
import UIKit

class GalleryCell: UICollectionViewCell {
    static let identifier = "collectionCell"
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(imageView)
        self.contraintsForImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
    func configureWithImage(image: UIImage) {
        self.imageView.image = image
    }
    
    func contraintsForImageView() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 3),
            imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -3),
            imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -3),
            imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 3)
            ])
    }
    
}
