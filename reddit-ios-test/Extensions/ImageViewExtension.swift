//
//  ImageViewExtension.swift
//  reddit-ios-test
//
//  Created by Argentino Ducret on 03/05/2020.
//  Copyright © 2020 Argentino Ducret. All rights reserved.
//

import UIKit

extension UIImageView {

    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }

}
