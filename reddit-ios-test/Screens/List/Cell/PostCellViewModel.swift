//
//  PostCellViewModel.swift
//  reddit-ios-test
//
//  Created by Argentino Ducret on 02/05/2020.
//  Copyright © 2020 Argentino Ducret. All rights reserved.
//

import Foundation

final class PostCellViewModel {

    var didUpdate: ((PostCellViewModel) -> Void)?
    var didDismiss: (() -> Void)?

    let title: String
    let subtitle: String
    let imageURL: URL?
    private(set) var isUnread: Bool = true
    let comments: String
    let timeAgo: String
    let dismissButton: String
    let post: Post

    init(post: Post) {
        self.post = post
        title = post.author
        subtitle = post.title
        imageURL = post.image
        comments = "\(post.amountOfComments) comments"
        timeAgo = post.creationDate.timeAgo()
        dismissButton = "Dismiss Post"
    }

    func didSelect() {
        isUnread = false
        didUpdate?(self)
    }
}
