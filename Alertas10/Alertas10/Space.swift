//
//  Space.swift
//  Alertas10
//
//  Created by Luis Llorente Tovar on 14/6/17.
//  Copyright © 2017 UPM. All rights reserved.
//

import Swift
import Foundation

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}

extension Data {
    var hexDescription: String {
        return reduce("") {$0 + String(format: "%02x", $1)}
    }
}
