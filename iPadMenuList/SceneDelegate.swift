//
//  SceneDelegate.swift
//  iPadMenuList
//
//  Created by Ashlee Muscroft on 08/10/2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?
    //new iOS14 declare a double column style
    let splitViewController = UISplitViewController(style: .doubleColumn)
    let sidebarViewController = SideBarViewController()
    let myHomeViewController = UIViewController()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        //UISplitViewControllerDelegate
        splitViewController.delegate = self
        //set which view is what
        splitViewController.setViewController(sidebarViewController, for: .primary)
        splitViewController.setViewController(myHomeViewController, for: .secondary)
        
        //setup of sidebar and detail controllers
        sidebarViewController.navigationController?.navigationBar.prefersLargeTitles = true
        myHomeViewController.navigationController?.navigationBar.prefersLargeTitles = true
        
        sidebarViewController.title = "Home"
        myHomeViewController.title = "Home"
        
        //appear side by side when a column is shown, use tile style.
        splitViewController.preferredSplitBehavior = .tile
        //'color' statusbar
        sidebarViewController.navigationController!.navigationBar.barStyle = .default
        myHomeViewController.navigationController!.navigationBar.barStyle = .black
        //start styling your navigation controllers, As i've set preferesLargeTitles, style the navBars largeTitleTextAttributes
        myHomeViewController.navigationController!.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        //style viewcontroller
        myHomeViewController.view.backgroundColor = .clear
        //let temptingAzure = [UIColor.blue.cgColor,UIColor.green.cgColor]
        let dark = UIColor(hue: 142.4/255, saturation: 92.2/255, brightness: 74.9/255, alpha: 1).cgColor
        let purple = UIColor(hue: 199.6/255, saturation: 82.1/255, brightness: 75.9/255, alpha: 1).cgColor
        let temptingAzure = [purple,dark]
            
        let backgroundGradient = CAGradientLayer()
        backgroundGradient.colors = temptingAzure
        backgroundGradient.locations = [0.0,1.0]
        backgroundGradient.frame = myHomeViewController.view.frame
        myHomeViewController.view.layer.insertSublayer(backgroundGradient, at: 0 )
        // always have primary and secondary sidebyside
        //splitViewController.preferredDisplayMode = .oneBesideSecondary
        splitViewController.show(.primary)
        splitViewController.show(.secondary)
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = splitViewController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

