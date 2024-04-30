//
//  WMKeyboardLogManager.swift
//  WebimKeyboard
//
//  Created by Аслан Кутумбаев on 31.08.2023.
//

import Foundation

public class WMKeyboardLogManager {
    public static var shared = WMKeyboardLogManager()
    var logContainer = [String]()
    
    public func getLogs() -> [String] {
        return logContainer
    }
}
