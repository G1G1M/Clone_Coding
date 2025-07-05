//
//  SceneDelegate.swift
//  Neflix_Clone_Coding
//
//  Created by KIM JIWON on 7/4/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let tabBarVC = UITabBarController()
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = SearchViewController()
        let vc3 = CSViewController()
        let vc4 = DownloadViewController()
        let vc5 = MoreViewController()
        
        vc1.title = "Home"
        vc2.title = "Search"
        vc3.title = "Coming Soon"
        vc4.title = "Downloads"
        vc5.title = "More"
        
        tabBarVC.setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: false)
        
        let tabBarBackgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1.0)
        let unselectedColor = UIColor(red: 140/255, green: 135/255, blue: 135/255, alpha: 1.0)

        tabBarVC.tabBar.backgroundColor = tabBarBackgroundColor
        tabBarVC.tabBar.tintColor = .white
        tabBarVC.tabBar.unselectedItemTintColor = unselectedColor

        // 아이콘 설정 (색상 바뀌게 설정)
        vc1.tabBarItem.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        vc2.tabBarItem.image = UIImage(named: "search")?.withRenderingMode(.alwaysTemplate)
        vc3.tabBarItem.image = UIImage(named: "coming_soon")?.withRenderingMode(.alwaysTemplate)
        vc4.tabBarItem.image = UIImage(named: "download")?.withRenderingMode(.alwaysTemplate)
        vc5.tabBarItem.image = UIImage(named: "more")?.withRenderingMode(.alwaysTemplate)
        
        window.rootViewController = tabBarVC
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) { }
    func sceneDidBecomeActive(_ scene: UIScene) { }
    func sceneWillResignActive(_ scene: UIScene) { }
    func sceneWillEnterForeground(_ scene: UIScene) { }
    func sceneDidEnterBackground(_ scene: UIScene) { }
}
