//
//  RegexService.swift
//  Vipspad
//
//  Created by Azure on 25/1/23.
//

import Foundation

class RegexService {

    static func compare(pattern: String, text: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let range = NSRange(location: 0, length: text.utf16.count)
            let matches = regex.matches(in: text, range: range)
            if matches.count > 0 {
                return true
            } else {
                return false
            }
        } catch {
            print("An error occurred: \(error)")
            return false
        }
    }

}
