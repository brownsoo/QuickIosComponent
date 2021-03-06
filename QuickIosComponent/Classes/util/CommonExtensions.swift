//
//  NumberExtension.swift
//  StudioBase
//
//  Created by hyonsoo han on 2018. 3. 2..
//  Copyright © 2018년 StudioMate. All rights reserved.
//

import Foundation

public extension CGPoint {
    func distance(toPoint p:CGPoint) -> CGFloat {
        return sqrt(pow(x - p.x, 2) + pow(y - p.y, 2))
    }
}

public extension Int {
    func twoDigitString() -> String {
        if self < 10 {
            return "0\(self)"
        } else {
            return "\(self)"
        }
    }
    func string() -> String {
        return "\(self)"
    }
}

public extension Float {
    func twoDigitString() -> String {
        let int = Int(self)
        return int.twoDigitString()
    }
}

public extension Double {
    /// 두자리 문자로
    func twoDigitString() -> String {
        let int = Int(self)
        return int.twoDigitString()
    }
}

public extension NSMutableData {
    func appendString(_ string: String) {
        append(string.data(using: String.Encoding.utf8, allowLossyConversion: false)!)
    }
}

public extension Date {

    /// Local weekday 1~7
    var weekday: Int {
        let cal = TimeUtil.calendar
        return cal.component(.weekday, from: self)
    }
    
    /// Local weekday index : 0~6
    var weekdayIndex: Int {
        let cal = TimeUtil.calendar
        return cal.component(.weekday, from: self) - cal.firstWeekday
    }
    
    /// Local weekday symbol
    var weekdayShortSymbol: String {
        return TimeUtil.calendar.shortWeekdaySymbols[weekdayIndex]
    }
    /// Local weekday symbol
    var weekdayFullSymbol: String {
        return TimeUtil.calendar.weekdaySymbols[weekdayIndex]
    }
    
    var day: Int {
        let cal = TimeUtil.calendar
        let comps = cal.dateComponents([.day], from: self)
        return comps.day!
    
    }
    
    func yyyyMMdd_HHmmss(_ join: String = "/") -> String {
        let form = DateFormatter()
        form.locale = TimeUtil.currentLocale
        form.dateFormat = "yyyy\(join)MM\(join)dd HH:mm:ss"
        return form.string(from: self)
    }

    func zero() -> Date {
        let cal = TimeUtil.calendar
        let comps = cal.dateComponents([.year, .month, .day], from: self)
        return TimeUtil.date(
            from: "\(comps.year!)-\(comps.month!)-\(comps.day!) 00:00:00",
            format: "yyyy-MM-dd HH:mm:ss")!
    }
}
