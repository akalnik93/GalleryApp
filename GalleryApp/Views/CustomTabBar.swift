import Foundation
import UIKit

class CustomTabBar: UITabBarController {
    private func setupTabBar() {
        self.tabBar.backgroundColor = .systemGray6
        self.tabBar.backgroundImage = UIImage()
        
        guard let tabBarItemGallery = self.tabBar.items?[0] else { return }
        guard let tabBarItemFavorites = self.tabBar.items?[1] else { return }
        
        guard let galleryImage = UIImage(named: "Gallery") else { return }
        guard let favoritesImage = UIImage(named: "Favorites") else { return }
        
        galleryImage.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        tabBarItemGallery.selectedImage = galleryImage
        tabBarItemGallery.image = galleryImage
        tabBarItemGallery.imageInsets = UIEdgeInsets(top: 25, left: 0, bottom: -10, right: 0)
        
        favoritesImage.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        tabBarItemFavorites.selectedImage = favoritesImage
        tabBarItemFavorites.image = favoritesImage
        tabBarItemFavorites.imageInsets = UIEdgeInsets(top: 20, left: 0, bottom: -10, right: 0)
        
        self.selectedIndex = 0
    }
    
    convenience init(viewControllers: [UIViewController]) {
        self.init()
        self.setViewControllers(viewControllers, animated: true)
        self.setupTabBar()
    }

}
