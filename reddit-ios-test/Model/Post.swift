//
//  Post.swift
//  reddit-ios-test
//
//  Created by Argentino Ducret on 30/04/2020.
//  Copyright © 2020 Argentino Ducret. All rights reserved.
//

import Foundation

struct Post {
    let id: String
    let title: String
    let author: String
    let image: URL?
    let amountOfComments: Int
    let creationDate: Date
}

extension Post: Decodable {

    enum CodingKeys: CodingKey {
        case data
    }

    enum PostKeys: String, CodingKey {
        case id
        case title
        case author
        case image = "thumbnail"
        case amountOfComments = "num_comments"
        case creationDate = "created_utc"
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        let d = try c.nestedContainer(keyedBy: PostKeys.self, forKey: .data)
        id = try d.decode(String.self, forKey: .id)
        title = try d.decode(String.self, forKey: .title)
        author = try d.decode(String.self, forKey: .author)
        let imageURL = try d.decode(String.self, forKey: .image)
        image = imageURL.isEmpty ? nil : URL(string: imageURL)
        amountOfComments = try d.decode(Int.self, forKey: .amountOfComments)
        let timeIntervalSince1970 = try d.decode(TimeInterval.self, forKey: .creationDate)
        creationDate = Date(timeIntervalSince1970: timeIntervalSince1970)
    }

}
