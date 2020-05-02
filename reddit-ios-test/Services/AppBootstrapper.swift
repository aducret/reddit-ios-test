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
        let postListViewModel = PostListViewModel(posts: [Post(title: "Post 1"), Post(title: "Post 2"), Post(title: "Post 3")])
        let postListViewController = PostListViewController(viewModel: postListViewModel)
        let postDetailsViewController = PostDetailsViewController(nibName: "PostDetailsViewController", bundle: nil)
        let splitViewController = UISplitViewController()
        splitViewController.viewControllers = [postListViewController, postDetailsViewController]
        window.rootViewController = splitViewController
        window.makeKeyAndVisible()
    }

}
