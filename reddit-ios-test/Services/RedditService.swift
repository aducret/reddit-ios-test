//
//  RedditService.swift
//  reddit-ios-test
//
//  Created by Argentino Ducret on 04/05/2020.
//  Copyright © 2020 Argentino Ducret. All rights reserved.
//

import Foundation

protocol RedditServiceProtocol {

    func fetchPosts(handlePosts: @escaping ([Post]) -> Void, handleError: @escaping (Error) -> Void)

}

struct RedditService: RedditServiceProtocol {

    func fetchPosts(handlePosts: @escaping ([Post]) -> Void, handleError: @escaping (Error) -> Void) {
        let url = URL(string: "https://www.reddit.com/r/all/.json")!

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
