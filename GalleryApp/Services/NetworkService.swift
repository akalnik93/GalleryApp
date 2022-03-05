import UIKit

protocol NetworkServiceProcotol {
    
    var delegate: RouterProtocol? { get set }
    func getPictureModels() -> [PictureModel]
    func cleanPictureModels()
    func fetchPhotosByRequest(text: String?)

}

class NetworkService: NetworkServiceProcotol {
    static let shared = NetworkService()
    
    init() {
        self.fetchPhotosByRequest(text: nil)
    }
    
    var delegate: RouterProtocol?

    var pictureModels: [PictureModel] = []
    
    var results: [Result] = []
    
    func getPictureModels() -> [PictureModel] {
        return self.pictureModels
    }
    
    func cleanPictureModels() {
        self.pictureModels = []
    }
    
    func fetchPhotosByRequest(text: String?) {
        guard let url = urlStringWithText(text: text) else { return }
        self.fetchPhotos(url: url) { results in
        for result in results {
            let pictureModel = PictureModel(result: result)
            self.pictureModels.append(pictureModel)
            }
        }
    }
    
    private func urlStringWithText(text: String?) -> URL? {
        var result = "random"
        if text != nil {
            guard let text = text else { return nil }
            result = text
        }
        let urlString = "https://api.unsplash.com/search/photos?page=1&per_page=30&query=\(result)&orientation=squarish&client_id=LtsTe5mVTRCBj9M0LL1P3sE2j7F9AGaLbkUF8CvCoHI"
        guard let url = URL(string: urlString) else { return nil }
        return url
    }
    
    private func fetchPhotos(url: URL?, completion: @escaping([Result]) -> Void) {
        self.cleanPictureModels()
        guard let url = url else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
                self?.results = jsonResult.results
                if self?.results.count == 0 {
                    DispatchQueue.main.async {
                        self?.delegate?.showAlert()
                    }
                }
                completion(jsonResult.results)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func fetchPictureByUrlString(url: String, completion: @escaping(UIImage?) -> Void) {
        if let url = URL(string: url) {
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil else { return }
                let image = UIImage(data: data)
                completion(image)
                DispatchQueue.main.async {
                    self.delegate?.reloadData()
                }
            }
            task.resume()
        }
    }
    
}
