//
//  BatchUpdate.swift
//  Skillbox_m14
//
//  Created by Kravchuk Sergey on 08.11.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//

import Foundation

enum BatchUpdate {
    case initial
    case update(deletions: [Int], insertion: [Int], modifications: [Int])
    case error(_: Error)
}
