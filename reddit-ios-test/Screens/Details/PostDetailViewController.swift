//
//  PostDetailViewController.swift
//  reddit-ios-test
//
//  Created by Argentino Ducret on 28/04/2020.
//  Copyright © 2020 Argentino Ducret. All rights reserved.
//

import UIKit

final class PostDetailsViewController: UIViewController {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    private let viewModel: PostDetailsViewModel

    init(viewModel: PostDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "PostDetailsViewController", bundle: nil)
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
}

// MARK: - Private
private extension PostDetailsViewController {

    func setupBindings() {
        authorLabel.text = viewModel.author
        titleLabel.text = viewModel.title

        if let imageURL = viewModel.postImageURL {
            postImageView.load(url: imageURL)
        }
    }

    func setupView() {
        authorLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.font = UIFont.systemFont(ofSize: 14)
    }

}

