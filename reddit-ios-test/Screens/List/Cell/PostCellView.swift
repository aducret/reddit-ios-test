//
//  PostCellView.swift
//  reddit-ios-test
//
//  Created by Argentino Ducret on 02/05/2020.
//  Copyright © 2020 Argentino Ducret. All rights reserved.
//

import UIKit

final class PostCellView: UITableViewCell {

    @IBOutlet weak var unreadView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setupView()
    }

    func setup(with viewModel: PostCellViewModel) {
        unreadView.isHidden = !viewModel.isUnread
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        dismissButton.setTitle(viewModel.dismissButton, for: .normal)
        commentsLabel.text = viewModel.comments
        timeAgoLabel.text = viewModel.timeAgo

        if let imageURL = viewModel.imageURL {
            postImageView.load(url: imageURL)
        } else {
            postImageView.isHidden = true
        }

        viewModel.didUpdate = { [weak self] viewModel in
            self?.unreadView.isHidden = !viewModel.isUnread
        }
    }
}

// MARK: - Private
private extension PostCellView {

    func setupView() {
        unreadView.layer.cornerRadius = unreadView.frame.width / 2.0
        unreadView.backgroundColor = .blue
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        commentsLabel.font = UIFont.systemFont(ofSize: 12)
        commentsLabel.textColor = .orange
        dismissButton.tintColor = .red
        dismissButton.setTitleColor(.red, for: .normal)
        dismissButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        timeAgoLabel.font = UIFont.systemFont(ofSize: 12)
        postImageView.contentMode = .scaleToFill
    }

}
