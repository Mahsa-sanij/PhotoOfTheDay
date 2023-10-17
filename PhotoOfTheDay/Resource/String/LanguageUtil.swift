//
//  LanguageUtil.swift
//  PhotoOfTheDay
//
//  Created by Mahsa Sanij on 10/15/23.
//

import Foundation
class LangUtil: NSObject {
    
    static private(set) var lang: String = "Base"
    private static let defaultLang = "Base"
    
    static func changeLanguage(to newLang: String) {
        UserDefaults.standard.setValue(newLang, forKey: "selectedLanguage")
        UserDefaults.standard.synchronize()
        
        lang = newLang
    }
    
    static func loadLanguage() {
        let targetLang = UserDefaults.standard.object(forKey: "selectedLanguage") as? String
        lang = targetLang ?? defaultLang
    }
}
