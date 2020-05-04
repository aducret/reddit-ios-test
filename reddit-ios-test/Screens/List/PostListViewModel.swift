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

    init() {
        setupViewModel()
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
}

// MARK: - Private
private extension PostListViewModel {

    func setupViewModel() {
        let url = URL(string: "https://www.reddit.com/r/all/.json")!

        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard
                let data = data,
                let strongSelf = self
            else { return }

            print(String(data: data, encoding: .utf8)!)

            let decoder = JSONDecoder()
            do {
                let posts = try decoder.decode(Tops.self, from: data).posts
                strongSelf.cellViewModels = posts.map(PostCellViewModel.init)
                strongSelf.didUpdate?(strongSelf)
            } catch(let error) {
                print("Error: \(error)")
                strongSelf.didError?(error)
            }
        }

        task.resume()
    }

}
