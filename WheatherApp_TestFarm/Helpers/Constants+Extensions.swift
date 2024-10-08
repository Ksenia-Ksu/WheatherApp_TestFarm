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
    static func dateFormatter(string: String, language: Language) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        switch language {
          case .en:
            dateFormatter.locale = Locale(identifier: "en_En")
        case .ru:
            dateFormatter.locale = Locale(identifier: "ru_Ru")
        }
      
        let date = dateFormatter.date(from: string)
        dateFormatter.setLocalizedDateFormatFromTemplate("dd.MM.yy")
        guard let date = date else { return ""}
        return (dateFormatter.string(from: date))
    }
}

public extension String {
    func firstCharUppercased() -> String {
        return prefix(1).uppercased() + self.dropFirst()
    }
    
    var localized: String {
          return NSLocalizedString(self, comment:"")
      }
}


