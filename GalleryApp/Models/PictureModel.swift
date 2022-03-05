import UIKit

class PictureModel {
    var picture: UIImage = UIImage()
    var id: String = ""
    var authorName: String = ""
    var createDate: String = ""
    var location: String = ""
    var likes: String = "0"
    var isFavorite: Bool = false
    
    init(result: Result) {
        NetworkService.shared.fetchPictureByUrlString(url: result.urls.regular) { image in
            guard let image = image else { return }
            self.picture = image
        }
        self.id = result.id
        guard let authorName = result.user.first_name else { return }
        self.authorName = authorName
        guard let createDate = DateFormatorService.shared.formattedDateFromString(dateString: result.created_at, withFormat: "dd.MM.yy") else { return }
        self.createDate = createDate
        guard let location = result.user.location else { return }
        self.location = location
        self.likes = String(describing: result.likes)
    }
    
}
