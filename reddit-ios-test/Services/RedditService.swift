//
//  RedditService.swift
//  reddit-ios-test
//
//  Created by Argentino Ducret on 04/05/2020.
//  Copyright © 2020 Argentino Ducret. All rights reserved.
//

import Foundation

protocol RedditServiceProtocol {

    func fetchPosts(count: Int, before: String?, limit: Int, handlePosts: @escaping ([Post]) -> Void, handleError: @escaping (Error) -> Void)

}

extension RedditServiceProtocol {

    func fetchPosts(count: Int, before: String?, handlePosts: @escaping ([Post]) -> Void, handleError: @escaping (Error) -> Void) {
        fetchPosts(count: count, before: before, limit: 20, handlePosts: handlePosts, handleError: handleError)
    }

}

struct RedditService: RedditServiceProtocol {

    func fetchPosts(count: Int, before: String?, limit: Int, handlePosts: @escaping ([Post]) -> Void, handleError: @escaping (Error) -> Void) {
        var urlString = "https://www.reddit.com/r/all/.json?limit=\(limit)"

        if let before = before {
            urlString += "&after=t3_\(before)&count=\(count)"
        }

        let url = URL(string: urlString)!

        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }

            print(String(data: data, encoding: .utf8)!)

            let decoder = JSONDecoder()
            do {
                let posts = try decoder.decode(Tops.self, from: data).posts
                handlePosts(posts)
            } catch(let error) {
                print("Error: \(error)")
                handleError(error)
            }
        }

        task.resume()
    }

}
