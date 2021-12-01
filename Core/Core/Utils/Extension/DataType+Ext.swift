//
//  DataType+Ext.swift
//  Gamepedia
//
//  Created by Tommy Rachmat on 02/11/21.
//

import Foundation

extension Double {
    func toString() -> String {
        return String(format: "%.2f", self)
    }
}

extension String {
    func removeHtmlTag() -> String {
        var string = self
        string = string.replacingOccurrences(of: "<p>", with: "")
        string = string.replacingOccurrences(of: "</p>", with: "")
        string = string.replacingOccurrences(of: "<br />", with: "")
        return string
    }

    func convertDateFormat() -> String {
        let rawDateString = self
        let rawDateFormatter = DateFormatter()
        rawDateFormatter.dateFormat = "yyyy-MM-dd"
        let date = rawDateFormatter.date(from: rawDateString)!
        let convertedDateFormatter = DateFormatter()
        convertedDateFormatter.dateFormat = "MMM d, y"
        return convertedDateFormatter.string(from: date)
    }
}
