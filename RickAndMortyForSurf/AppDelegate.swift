//
//  AppDelegate.swift
//  RickAndMortyForSurf
//
//  Created by office-mac on 17.07.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow()
        window.rootViewController = CharactersListViewController(viewModel: CharactersListDefaultViewModel(networkService: NetworkServiceImpl()))
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
    }
}

