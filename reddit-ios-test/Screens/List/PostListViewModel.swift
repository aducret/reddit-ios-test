//
//  PostListViewModel.swift
//  reddit-ios-test
//
//  Created by Argentino Ducret on 28/04/2020.
//  Copyright © 2020 Argentino Ducret. All rights reserved.
//

import Foundation

final class PostListViewModel {

    var didUpdate: ((PostListViewModel) -> Void)?
    var didError: ((Error) -> Void)?
    let title = "Reddit Posts"
    private(set) var cellViewModels: [PostCellViewModel] = []

    private let redditService: RedditServiceProtocol

    init(redditService: RedditServiceProtocol = RedditService()) {
        self.redditService = redditService
    }

    func didSelect(index: Int) {
        guard let post = cellViewModels[safe: index] else { return }
        post.didSelect()
    }

    func createDetailViewModel(index: Int) -> PostDetailsViewModel? {
        guard let post = cellViewModels[safe: index]?.post else { return nil }

        return PostDetailsViewModel(post: post)
    }

    func dismiss(post: Post) -> Int? {
        guard let index = cellViewModels.firstIndex(where: { $0.post.id == post.id }) else { return nil }
        cellViewModels.remove(at: index)
        return index
    }

    func dismissAll() {
        cellViewModels = []
    }

    func fetchPosts() {
        redditService.fetchPosts(handlePosts: { [weak self] posts in
            guard let strongSelf = self else { return }

            strongSelf.cellViewModels = posts.map(PostCellViewModel.init)
            strongSelf.didUpdate?(strongSelf)
        }, handleError: { [weak self] error in
            self?.didError?(error)
        })
    }
}
