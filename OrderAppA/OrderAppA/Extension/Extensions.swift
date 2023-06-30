//
//  Extensions.swift
//  OrderAppA
//
//

import Foundation
import SwiftUI


class ColorTheme {
    let orange :Color = Color("orange")
    let purple :Color = Color("purple")
}


extension Color {
    static let theme = ColorTheme()
}

extension Date {
    func todayFormater() -> String{
        let date = self
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM YYYY"
        formatter.locale = .init(identifier: "fr_FR")
        return formatter.string(from: date)
    }
}

