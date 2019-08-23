//
//  Presentable.swift
//  iOS Sample Architecture
//
//  Created by Hedy Pamungkas on 23/08/19.
//  Copyright © 2019 hedy. All rights reserved.
//

import UIKit

protocol Presentable {
    func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {
    
    func toPresent() -> UIViewController? {
        return self
    }
    
    func availableViewController() -> UIViewController? {
        return self
    }
    
    func wrapInNavigationController() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}
