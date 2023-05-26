//
//  UIColorExtension.swift
//  WallNote
//
//  Created by Ahmad Fariz on 25/05/23.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
    
    static let primaryColor = Color(hex: 0xF4C91A)
    
    static let secondaryColor = Color(hex: 0x886E07)
    
}
