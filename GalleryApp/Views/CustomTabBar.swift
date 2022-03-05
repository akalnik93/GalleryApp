import UIKit

class CustomTabBar: UITabBarController {
    
    private func setupTabBar() {
        
        self.tabBar.backgroundColor = .systemGray6
        self.tabBar.backgroundImage = UIImage()
        
        guard let tabBarItemGallery = self.tabBar.items?[0] else { return }
        guard let tabBarItemFavorites = self.tabBar.items?[1] else { return }
        
        guard let galleryImage = UIImage(named: "Gallery") else { return }
        guard let favoritesImage = UIImage(named: "Favorites") else { return }
        
        tabBarItemGallery.image = galleryImage
        tabBarItemGallery.title = "Gallery"
        
        tabBarItemFavorites.image = favoritesImage
        tabBarItemFavorites.title = "Favorites"

        self.selectedIndex = 0
    }
    
    convenience init(viewControllers: [UIViewController]) {
        self.init()
        self.setViewControllers(viewControllers, animated: true)
        self.setupTabBar()
    }

}
