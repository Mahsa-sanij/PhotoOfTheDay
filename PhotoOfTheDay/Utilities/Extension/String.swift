//
//  String.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/15/23.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: LangUtil.lang, bundle: .main, value: "", comment: "")
    }
}
