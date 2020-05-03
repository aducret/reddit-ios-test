//
//  AppBootstrapper.swift
//  reddit-ios-test
//
//  Created by Argentino Ducret on 30/04/2020.
//  Copyright © 2020 Argentino Ducret. All rights reserved.
//

import UIKit

struct AppBootstrapper {

    static func bootstrap(window: UIWindow) {
        let postListViewModel = PostListViewModel()
        let postListViewController = PostListViewController(viewModel: postListViewModel)
        let postListNavigationController = UINavigationController(rootViewController: postListViewController)

        let postDetailsViewController = PostDetailsViewController(nibName: "PostDetailsViewController", bundle: nil)
        let postDetailsNavigationController = UINavigationController(rootViewController: postDetailsViewController)

        let splitViewController = UISplitViewController()
        splitViewController.delegate = postListViewController
        splitViewController.viewControllers = [postListNavigationController, postDetailsNavigationController]
        window.rootViewController = splitViewController

        window.makeKeyAndVisible()
    }

}
