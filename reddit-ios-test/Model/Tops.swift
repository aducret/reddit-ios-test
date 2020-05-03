//
//  Tops.swift
//  reddit-ios-test
//
//  Created by Argentino Ducret on 03/05/2020.
//  Copyright © 2020 Argentino Ducret. All rights reserved.
//

struct Tops {
    let posts: [Post]
}

extension Tops: Decodable {

    enum CodingKeys: CodingKey {
        case data
    }

    enum DataKeys: CodingKey {
        case children
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let d = try container.nestedContainer(keyedBy: DataKeys.self, forKey: .data)
        posts = try d.decode([Post].self, forKey: .children)
    }

}
