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
        let presenter = EmployeePairPresenter(viewModel: [EmployeePairSectionModel(header: EmployeePairSectionModel.Header(title: "Total time worked together", subtitle: "12345"), items: [EmployeePairSectionModel.EmployeePairItem(employee1ID: "11", employee2ID: "22", projectID: "123", timeWorked: "1234"), EmployeePairSectionModel.EmployeePairItem(employee1ID: "11", employee2ID: "22", projectID: "1234", timeWorked: "12345"), EmployeePairSectionModel.EmployeePairItem(employee1ID: "11", employee2ID: "22", projectID: "1236", timeWorked: "12347")])])
        let view = EmployeePairViewController(presenter: presenter)
        presenter.view = view
        window?.rootViewController = UINavigationController(rootViewController: view)
        window?.makeKeyAndVisible()
    }
}


