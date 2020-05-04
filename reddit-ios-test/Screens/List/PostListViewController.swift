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
        setupBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension PostListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCellView", for: indexPath) as? PostCellView,
            let cellViewModel = viewModel.cellViewModels[safe: indexPath.row]
        else { return UITableViewCell() }

        cell.setup(with: cellViewModel)
        cellViewModel.didDismiss = { [weak self] in
            self?.dismiss(post: cellViewModel.post)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let postDetailsViewModel = viewModel.createDetailViewModel(index: indexPath.row) else { return }
        let postDetailsViewController = PostDetailsViewController(viewModel: postDetailsViewModel)
        splitViewController?.showDetailViewController(postDetailsViewController, sender: nil)

        viewModel.didSelect(index: indexPath.row)
    }

}

// MARK: - UISplitViewControllerDelegate
extension PostListViewController: UISplitViewControllerDelegate {

    func splitViewController( _ splitViewController: UISplitViewController,
                              collapseSecondary secondaryViewController: UIViewController,
                              onto primaryViewController: UIViewController) -> Bool {
        return true
    }

}

// MARK: - Private
private extension PostListViewController {

    func setupBindings() {
        viewModel.fetchPosts()

        viewModel.didUpdate = { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        viewModel.didError = { [weak self] error in
            guard let strongSelf = self else { return }

            let alert = UIAlertController(title: "Ups! There was an error", message: "error: \(error)", preferredStyle: .alert)
            alert.show(strongSelf, sender: nil)
        }

        title = viewModel.title
    }

    func setupView() {
        splitViewController?.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "PostCellView", bundle: nil), forCellReuseIdentifier: "PostCellView")
        dismissButton.addTarget(self, action: #selector(dismissAll), for: .touchUpInside)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshPosts), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    @objc
    func refreshPosts(refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
        viewModel.fetchPosts()
    }

    @objc
    func dismissAll() {
        tableView.beginUpdates()
        let indexes = (0..<viewModel.cellViewModels.count).map { IndexPath(row: $0, section: 0) }
        tableView.deleteRows(at: indexes, with: .fade)
        viewModel.dismissAll()
        tableView.endUpdates()
    }

    func dismiss(post: Post) {
        tableView.beginUpdates()
        if let row = viewModel.dismiss(post: post) {
            tableView.deleteRows(at: [IndexPath(row: row, section: 0)], with: .fade)
        }
        tableView.endUpdates()
    }

}
