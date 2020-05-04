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
    var isLoading: Bool = false
    let dismissButtonTitle = "Dismiss All"

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
        isLoading = true

        redditService.fetchPosts(
            count: 0,
            after: nil,
            handlePosts: { [weak self] posts in
                self?.isLoading = false
                guard let strongSelf = self else { return }

                strongSelf.cellViewModels = posts.map(PostCellViewModel.init)
                strongSelf.didUpdate?(strongSelf)
            }, handleError: { [weak self] error in
                self?.isLoading = false
                self?.didError?(error)
        })
    }

    func nextPage() {
        isLoading = true

        redditService.fetchPosts(
            count: cellViewModels.count,
            after: cellViewModels.last?.post.id,
            handlePosts: { [weak self] posts in
                self?.isLoading = false
                guard let strongSelf = self else { return }

                let newPosts = posts.map(PostCellViewModel.init)
                strongSelf.cellViewModels.append(contentsOf: newPosts)
                strongSelf.didUpdate?(strongSelf)
            }, handleError: { [weak self] error in
                self?.isLoading = false
                self?.didError?(error)
        })
    }
}
