//
//  YearMonthDay.swift
//  StudioBase
//
//  Created by hyonsoo han on 2018. 7. 20..
//  Copyright © 2018년 StudioMate. All rights reserved.
//

import Foundation

/// 년월일만 표현하는 모델
public struct YearMonthDay: Equatable {
    public let year: String
    public let month: String
    public let day: String
    
    public var y: Int {
        return Int(year)!
    }
    public var m: Int {
        return Int(month)!
    }
    public var d: Int {
        return Int(day)!
    }
    
    public var date: Date {
        return TimeUtil.date(from: yyyyMMdd(joiner: "-"), format: "yyyy-MM-dd")!
    }
    
    public func yyyyMMdd(joiner: String = "/") -> String {
        return [year, joiner, month, joiner, day].joined()
    }
    
    public func yyMMdd(joiner: String = "/") -> String {
        return [year.from(2, until: -1)!, joiner, month, joiner, day].joined()
    }
    
    fileprivate static func twoDigitString(_ value: Int) -> String {
        if value < 10 {
            return "0\(value)"
        } else {
            return "\(value)"
        }
    }
    
    public func compare(versus: YearMonthDay) -> Int {
        if y > versus.y {
            return 1
        } else if y < versus.y {
            return -1
        }
        if m > versus.m {
            return 1
        } else if m < versus.m {
            return -1
        }
        if d > versus.d {
            return 1
        } else if d < versus.d {
            return -1
        } else {
            return 0
        }
    }
}

public extension YearMonthDay {
    /// init with yyyy-MM-dd
    public init?(yyyyMMdd: String) {
        let format = DateFormatter()
        format.locale = TimeUtil.currentLocal
        format.dateFormat = "yyyy-MM-dd"
        let date = format.date(from: yyyyMMdd)
        if let date = date {
            let set: Set<Calendar.Component> = [.year, .month, .day]
            let comps = Calendar.current.dateComponents(set, from: date)
            self = YearMonthDay(
                year: "\(comps.year!)",
                month: YearMonthDay.twoDigitString(comps.month!),
                day: YearMonthDay.twoDigitString(comps.day!))
        } else {
            return nil
        }
    }
    /// init with now date
    public init() {
        self.init(TimeUtil.now)
    }
    
    public init(y: Int, m: Int, d: Int) {
        self = YearMonthDay(
            year: "\(y)",
            month: YearMonthDay.twoDigitString(m),
            day: YearMonthDay.twoDigitString(d))
    }
    
    /// init with date
    public init(_ date: Date) {
        let set: Set<Calendar.Component> = [.year, .month, .day]
        let comps = TimeUtil.calendar.dateComponents(set, from: date)
        self = YearMonthDay(
            y: comps.year!,
            m: comps.month!,
            d: comps.day!)
    }
}

public extension YearMonthDay {
    static func <(lhs: YearMonthDay, rhs: YearMonthDay) -> Bool {
        return lhs.compare(versus: rhs) < 0
    }
    static func >(lhs: YearMonthDay, rhs: YearMonthDay) -> Bool {
        return lhs.compare(versus: rhs) > 0
    }
    static func ==(lhs: YearMonthDay, rhs: YearMonthDay) -> Bool {
        return lhs.compare(versus: rhs) == 0
    }
    static func >=(lhs: YearMonthDay, rhs: YearMonthDay) -> Bool {
        let val = lhs.compare(versus: rhs)
        return val > 0 || val == 0
    }
    static func <=(lhs: YearMonthDay, rhs: YearMonthDay) -> Bool {
        let val = lhs.compare(versus: rhs)
        return val < 0 || val == 0
    }
}