//
//  DateExtension.swift
//  reddit-ios-test
//
//  Created by Argentino Ducret on 03/05/2020.
//  Copyright © 2020 Argentino Ducret. All rights reserved.
//

import Foundation

extension Date {

    func timeAgo() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }

}
