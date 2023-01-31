//
//  Sting.swift
//  Vipspad
//
//  Created by Azure on 31/1/23.
//

import Foundation

extension String {
    func convertDateString(fromFormat: String, toFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        guard let date = dateFormatter.date(from: self) else { return nil }
        dateFormatter.dateFormat = toFormat
        let toDateString = dateFormatter.string(from: date)
        return toDateString
    }
}
