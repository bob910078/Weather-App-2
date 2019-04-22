//
//  StringExtension.swift
//  Weather-App-2
//
//  Created by mitchell hudson on 11/13/15.
//  Copyright © 2015 mitchell hudson. All rights reserved.
//

import UIKit

extension NSString {
    func stringToAttributedStringWithFontFamily(fontFamily: NSString, and fontSize: NSString) -> NSAttributedString {
        var html = self
        
        while html.contains("\n") {
            let range = html.range(of: "\n")
            html.replacingCharacters(in: range, with: "</br>")
        }
        
        let p1: NSString = NSString.init(format: "<span style='font-family: %@; font-size: %@'>", fontFamily, fontSize)
        let p2: NSString = html
        let p3: NSString = "</span>"
        
        html = NSString.init(format: "%@%@%@", p1, p2, p3)
        
        let data = html.data(using: String.Encoding.unicode.rawValue, allowLossyConversion: true)
        let attrStr = try! NSAttributedString(data: data!, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        return attrStr
    }
}
