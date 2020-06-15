//
//  String+Extension.swift
//  FlowGuide
//
//  Created by Talish George on 22/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit

extension String {
    
    var hex: Int? {
        return Int(self, radix: 16)
    }

    func capitalizingFirstLetter() -> String {
        prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    func upperCamelCased() -> String? {
        self.lowercased()
            .split(separator: " ")
            .map { $0.lowercased().capitalizingFirstLetter() }
            .joined(separator: " ")
    }

    func lowerCamelCased() -> String? {
        guard let upperCased = self.upperCamelCased() else {
            return nil
        }
        return upperCased.prefix(1).lowercased() + upperCased.dropFirst()
    }

    var insertBraces: String {
        String(format: "(%@)", self)
    }

    func prefixWithImage(_ imageName: String) -> NSMutableAttributedString? {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: imageName)
        let attributedStringwithImage = NSMutableAttributedString(attachment: imageAttachment)
        let attribuedString = NSAttributedString(string: String(format: "  %@", self))
        attributedStringwithImage.append(attribuedString)
        return attributedStringwithImage
    }

    func formattedDateString(inFormat format: DateFormat) -> String {
        if let date = self.formattedDate() {
            let formatter = DateFormatter.formatter(with: format)
            return formatter.string(from: date)
        }
        return self
    }
    
    func formattedDate(from format: DateFormat = .defaultFormat,
                       withLocale: Locale = Locale(identifier: DateConstants.locale),
                       timeZone: Timezone = .none) -> Date? {
        let formatter = DateFormatter.formatter(with: format,
                                                forLocale: withLocale,
                                                withZone: timeZone)
        return formatter.date(from: self)
    }
    
    func attributedString(lineSpace: CGFloat,
                          font fontName: UIFont?,
                          color textColor: UIColor?,
                          isStrikethrough: Bool = false,
                          textAlignment: NSTextAlignment? = nil) -> NSAttributedString {
        var attributes = [NSAttributedString.Key: Any]()
        attributes[NSAttributedString.Key.foregroundColor] = textColor
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace
        paragraphStyle.lineBreakMode = .byWordWrapping
        if let alignment = textAlignment {
            paragraphStyle.alignment = alignment
        }
        attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        attributes[NSAttributedString.Key.font] = fontName
        if isStrikethrough {
            attributes[NSAttributedString.Key.strikethroughStyle] = 2
            attributes[NSAttributedString.Key.strikethroughColor] = textColor
        }
        let attributedString = NSAttributedString(string: self, attributes: attributes)
        return attributedString
    }
    
    func localized() -> String {
        // return NSLocalizedString(self, value: "**\(self)**", comment: "")
        let value = NSLocalizedString(self, comment: "")
        if value != self || NSLocale.preferredLanguages.first == "en" {
            return value
        }
        
        // Fall back to en
        guard
            let path = Bundle.main.path(forResource: "en", ofType: "lproj"),
            let bundle = Bundle(path: path), !value.isEmpty
            else { return "" }
        return NSLocalizedString(self, bundle: bundle, comment: "")
    }

//    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
//        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
//    }
    
    ///These subscripts help in accessing a substring easily, like xString[0...2] or xString[1..<3]
    
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }

    /// Variable to validate wether the all charactes are numeric
    var isNumeric: Bool {
        !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }

    /// Variable to validate wether the textfield only contains numeric values
    var numberFiltered: Bool {
        let characterSet = NSCharacterSet.alphanumerics.inverted
        let characterSetArray = self.components(separatedBy: characterSet)
        return self != characterSetArray.joined()
    }
    
    func getAttributedStringForAlignemnt() -> NSMutableAttributedString {
        let attrString = NSMutableAttributedString(string: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attrString.length))
        return attrString
    }
    
    var digits: String {
        components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
    
    var validated: String {
        self
    }

    func applyBoardingPassErrorStyle() -> NSAttributedString? {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 28.0
        paragraphStyle.maximumLineHeight = 28.0
        let description = NSAttributedString(string: self, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return description
    }

    func containsIgnoringCase(find: String) -> Bool {
        self.range(of: find, options: .caseInsensitive) != nil
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
