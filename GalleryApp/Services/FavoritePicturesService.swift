import Foundation

class FavoritePicturesService {
    static let shared = FavoritePicturesService()
    
    private var favoritePictureModels: [PictureModel] = []
    
    func addFavoritePicture(pictureModel: PictureModel) {
        self.favoritePictureModels.append(pictureModel)
    }
    
    func getFavoritePictures() -> [PictureModel] {
        return self.favoritePictureModels
    }

    func removeFavoritePicture(pictureModel: PictureModel) {
        for i in 0...self.favoritePictureModels.count-1 {
            if pictureModel.id == self.favoritePictureModels[i].id {
                self.favoritePictureModels.remove(at: i)
                break
            }
        }
    }
    
    func ifIsFavorite(pictureModel: PictureModel) -> Bool {
        if self.favoritePictureModels.count > 0 {
            for i in 0...self.favoritePictureModels.count-1 {
                if pictureModel.id == self.favoritePictureModels[i].id {
                    pictureModel.isFavorite = true
                return true
                }
            }
        }
        return false
    }

}
