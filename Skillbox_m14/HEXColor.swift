//
//  HEXColor.swift
//  Skillbox_m14
//
//  Created by Kravchuk Sergey on 09.11.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//

import UIKit

extension UIColor {

    static func hexColor(hex:String) -> UIColor {
            var cString:String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

            if (cString.hasPrefix("#")) {
                cString = String(cString[cString.index(cString.startIndex, offsetBy: 1)...])
            }

            if (cString.count != 6) {
                return UIColor.gray
            }

            var rgbValue:UInt64 = 0

            Scanner(string: cString).scanHexInt64(&rgbValue)

            return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
        }
    
    

    // MARK: - Computed Properties

    var toHex: String {
        return toHex()
    }

    // MARK: - From UIColor to String

    func toHex(alpha: Bool = false) -> String {
        guard let components = cgColor.components, components.count >= 3 else {
            fatalError("Invalid color components")
        }

        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)

        if components.count >= 4 {
            a = Float(components[3])
        }

        if alpha {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }

}
