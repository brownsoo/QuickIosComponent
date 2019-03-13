//
//  StringExtension.swift
//  QuickIosComponent
//
//  Created by brownsoo han on 2017. 12. 21..
//  Copyright © 2017년 Hansoo.labs. All rights reserved.
//

import Foundation


public extension String {
    func attributed(fontSize: CGFloat? = nil) -> NSMutableAttributedString {
        if let size = fontSize {
            return NSMutableAttributedString(string: self,
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: size)])
        }
        return NSMutableAttributedString(string: self)
    }

    func strike(style: NSUnderlineStyle = NSUnderlineStyle.single,
                 color: UIColor = UIColor.red.brightness(brightness: 0.5)) -> NSAttributedString {
        return NSAttributedString(string: self,
                                  attributes: [NSAttributedString.Key.strikethroughStyle: style.rawValue,
                                               NSAttributedString.Key.strikethroughColor: color])
    }
    func underline(style: NSUnderlineStyle = .single, color: UIColor? =  nil) -> NSMutableAttributedString {
        var attrs: [NSAttributedString.Key: Any] = [NSAttributedString.Key.underlineStyle: style.rawValue]
        if color != nil {
            attrs[NSAttributedString.Key.underlineColor] = color!
        }
        return NSMutableAttributedString(string: self, attributes: attrs)
    }

}

public extension NSMutableAttributedString {

    @discardableResult
    func bold(fontSize: CGFloat? = nil, fontName: String? = nil) -> NSMutableAttributedString {
        return applyFontStyle(fontSize: fontSize, fontName: fontName, weight: .bold)
    }

    @discardableResult
    func black(fontSize: CGFloat? = nil, fontName: String? = nil) -> NSMutableAttributedString {
        return applyFontStyle(fontSize: fontSize, fontName: fontName, weight: .black)
    }

    @discardableResult
    func regular(fontSize: CGFloat? = nil, fontName: String? = nil) -> NSMutableAttributedString {
        return applyFontStyle(fontSize: fontSize, fontName: fontName, weight: .regular)
    }

    @discardableResult
    func applyFontStyle(fontSize: CGFloat? = nil, fontName: String? = nil, weight: UIFont.Weight) -> NSMutableAttributedString {
        let size = fontSize ?? 12
        var font = fontName != nil ? UIFont(name: fontName!, size: size)
            : self.attribute(NSAttributedString.Key.font, at: 0, effectiveRange: nil) as? UIFont
        if font == nil {
            font = UIFont.systemFont(ofSize: size, weight: weight)
        }
        return applyFont(font!)
    }

    @discardableResult
    func applyFont(_ font: UIFont) -> NSMutableAttributedString {
        addAttribute(NSAttributedString.Key.font, value:font,
            range:NSRange(location: 0, length: self.length))
        return self
    }

    @discardableResult
    func underline(style: NSUnderlineStyle = .single, color: UIColor? =  nil) -> NSMutableAttributedString {
        addAttribute(NSAttributedString.Key.underlineStyle, value:style.rawValue,
            range:NSRange(location: 0, length: self.length))
        if color != nil {
            addAttribute(NSAttributedString.Key.underlineColor, value:color!,
                range:NSRange(location: 0, length: self.length))
        }
        return self
    }

    @discardableResult
    func add(_ attrString: NSAttributedString) -> NSMutableAttributedString {
        let m = self
        m.append(attrString)
        return m
    }

    @discardableResult
    func add(_ string: String) -> NSMutableAttributedString {
        let m = self
        m.append(NSAttributedString(string: string))
        return m
    }

    @discardableResult
    func color(_ color: UIColor, range: NSRange? = nil) -> NSMutableAttributedString {
        addAttribute(NSAttributedString.Key.foregroundColor, value: color,
            range: range ?? NSRange(location: 0, length: self.length))
        return self
    }

    @discardableResult
    func lineSpacing(lineSpacing: CGFloat = 0, lineHeightMultiple: CGFloat = 0) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle,
            range:NSRange(location: 0, length: self.length))
        return self

    }
}

public extension String {
    var isNotEmpty: Bool {
        return !isEmpty
    }
}

public extension String {
    /// new sub string
    func from(_ start: Int, until end: Int) -> String? {
        if start < self.count && start > -1 {
            let si = self.index(self.startIndex, offsetBy: start)
            let ei: String.Index
            if end < 0 || end >= self.count {
                ei = self.endIndex
            } else {
                ei = self.index(self.startIndex, offsetBy: end)
            }
            return String(self[si..<ei])
        } else {
            return nil
        }
    }

    func replace(_ target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString,
            options: NSString.CompareOptions.literal, range: nil)
    }
}

// extension for validation

public extension String {

    var hasOnlyNumber: Bool {
        if self.isEmpty {
            return false
        }
        do {
            let pattern = "[^0-9]"
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            return regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.count)).count == 0
        } catch {
            return false
        }
    }

    var isCellularPhoneFormat: Bool {
        if self.isEmpty || !self.hasOnlyNumber {
            return false
        }
        do {
            let pattern = "(01)[0,1,6,7,8,9][0-9]{7,8}"
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            return regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.count)).count > 0
        } catch {
            return false
        }
    }

    var isEmailFormat: Bool {
        if self.isEmpty {
            return false
        }
        do {
            let pattern = "^(([^<>()\\[\\]\\\\.,;:\\s@\"]" +
                "+(\\.[^<>()\\[\\]\\\\.,;:\\s@\"]+)*)|(\".+\"))" +
                "@" +
                "((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}])" +
                "|(([a-zA-Z-0-9]+\\.)+[a-zA-Z]{2,}))$"
            let regex = try NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
            return regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.count)).count > 0
        } catch {
            return false
        }
    }

    var hasOnlyAlphabetOrNumber: Bool {
        if self.isEmpty {
            return false
        }
        do {
            let pattern = "[^a-zA-Z0-9]"
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            return regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.count)).count == 0
        } catch {
            return false
        }
    }

    var hasNumber: Bool {
        if self.isEmpty {
            return false
        }
        do {
            let pattern = "[0-9]+"
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            return regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.count)).count > 0
        } catch {
            return false
        }
    }

    var hasAlphabet: Bool {
        if self.isEmpty {
            return false
        }
        do {
            let pattern = "[a-zA-Z]+"
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            return regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.count)).count > 0
        } catch {
            return false
        }
    }

    /// 다음 문자를 포함하는지 여부
    /// !  @  #  $  &  (  )  -  ‘  .  /  +  ,  “ ^ 공백
    var hasSpecialChar: Bool {
        if self.isEmpty {
            return false
        }
        do {
            let pattern = "[*\\^\\s!@#$&()\\-`.+,/\"]+"
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            return regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.count)).count > 0
        } catch {
            return false
        }
    }

    func toAppIdentifier() -> String {
        return "mate-user-\(self.prefix(20))"
    }
}
