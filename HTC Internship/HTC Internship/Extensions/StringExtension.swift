//
//  StringExtension.swift
//  HTC Internship
//
//  Created by Roman on 21/12/2019.
//  Copyright © 2019 Roman. All rights reserved.
//

import Foundation

extension String {
    func containsOnlyLetters() -> Bool {
        if self.isEmpty {
            return false
        }
        
        let lowerCased = self.lowercased()
        for ch in lowerCased {
            if !((ch >= "a" && ch <= "z") || (ch >= "а" && ch <= "я")) {
                return false
            }
        }
        
        return true
    }
}
