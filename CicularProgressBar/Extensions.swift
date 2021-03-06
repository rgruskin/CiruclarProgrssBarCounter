//
//  Extensions.swift
//  CicularProgressBar
//
//  Created by Rich Gruskin on 3/20/21.
//

import SwiftUI

extension Color {
    static func rgb(r: Double, g: Double, b: Double)->Color {
        return Color (red: r/255, green: g/255, blue: b/255)
    }
    static let backgroundColor = Color.rgb (r: 21, g: 22, b:33)
    static let outlineColor = Color.rgb (r: 54, g: 2255, b:203)
    static let trackColor = Color.rgb (r: 46, g: 56, b:95)
    static let pulsatingColor = Color.rgb (r: 73, g: 113, b:140)
}
