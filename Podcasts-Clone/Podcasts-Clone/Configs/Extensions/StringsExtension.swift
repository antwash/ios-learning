//  StringsExtension.swift
//  Podcasts-Clone
//  Created by Anthony Washington on 3/27/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

extension String {
    func secureHttps() -> String {
        return self.contains("https") ? self :
        self.replacingOccurrences(of: "http", with: "https")
    }
    
    func replaceHTML() -> String {
        let text = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return text.replacingOccurrences(of: "<[^>]+>",
                                         with: "",
                                         options: .regularExpression,
                                         range: nil)
    }
}
