//
//  SceneDelegate.swift
//  employees
//
//  Created by Miroslav Ganchev on 21.11.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        window = UIWindow()
        window?.windowScene = scene as? UIWindowScene
        let presenter = EmployeePairPresenter(viewModel: [])
        let view = EmployeePairViewController(presenter: presenter)
        presenter.view = view
        window?.rootViewController = UINavigationController(rootViewController: view)
        window?.makeKeyAndVisible()
    }
}


