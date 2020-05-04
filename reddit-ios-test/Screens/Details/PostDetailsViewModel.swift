//
//  PostDetailsViewModel.swift
//  reddit-ios-test
//
//  Created by Argentino Ducret on 28/04/2020.
//  Copyright © 2020 Argentino Ducret. All rights reserved.
//

import Foundation

struct PostDetailsViewModel {

    let author: String?
    let title: String?
    let postImageURL: URL?

    init(post: Post?) {
        author = post?.author
        title = post?.title
        postImageURL = post?.image
    }
}
