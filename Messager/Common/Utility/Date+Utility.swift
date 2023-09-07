//
//  Date+Utility.swift
//  Messager
//
//  Created by Kim Phong on 29/06/2023.
//

import Foundation

extension Date {
    public static let defaultFormat = "dd-MM-yyyy HH:mm:ss"
    public static let ICT = TimeZone(identifier: "Asia/Bangkok") // Hanoi -> Indochina Time (Asia/Bangkok)

    func format(_ format: String = "dd-MM-yyyy HH:mm:ss") -> String {
        self.format(format, timezone: TimeZone.current)
    }

    func defaultFormatICT() -> String {
        self.format(Date.defaultFormat, timezone: Date.ICT!)
    }

    func format(_ format: String = "dd-MM-yyyy HH:mm:ss", timezone: TimeZone) -> String {
        let defaultFormatter = DateFormatter()
        defaultFormatter.locale = Locale(identifier: "en_US_POSIX") // English (United States, Computer)
        defaultFormatter.dateFormat = format
        defaultFormatter.timeZone = timezone
        return defaultFormatter.string(from: self)
    }
}
