//
//  PostListViewController.swift
//  reddit-ios-test
//
//  Created by Argentino Ducret on 28/04/2020.
//  Copyright © 2020 Argentino Ducret. All rights reserved.
//

import UIKit

final class PostListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dismissButton: UIButton!

    private let viewModel: PostListViewModel

    init(viewModel: PostListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "PostListViewController", bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupViewModel()
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension PostListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel.posts[indexPath.row].title
        return cell
    }

}

// MARK: - Private
private extension PostListViewController {

    func setupViewModel() {

    }

    func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }

}
