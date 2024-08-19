//
//  Constants.swift
//  WheatherApp_TestFarm
//
//  Created by Ксения Кобак on 19.08.2024.
//

import UIKit

public struct Colors {
    static let background = UIColor(named: "BackgroundColor")
    static let text = UIColor(named: "TextColor")
}

public struct SFSymbols {
    static let localeSettings = "gearshape"
    static let search = "magnifyingglass"
}

public struct Formatter {
    static func dateFormatter(string: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let date = dateFormatter.date(from: string)
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd")
        guard let date = date else { return ""}
        return (dateFormatter.string(from: date))
    }
}

public extension String {
    func firstCharUppercased() -> String {
        return prefix(1).uppercased() + self.dropFirst()
    }
}


