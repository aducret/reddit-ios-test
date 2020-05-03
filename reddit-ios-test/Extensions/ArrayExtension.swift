//
//  ArrayExtension.swift
//  reddit-ios-test
//
//  Created by Argentino Ducret on 03/05/2020.
//  Copyright © 2020 Argentino Ducret. All rights reserved.
//

extension Array {

    subscript(safe index: Int) -> Element? {
        return index >= startIndex && index < endIndex ? self[index] : nil
    }

}
