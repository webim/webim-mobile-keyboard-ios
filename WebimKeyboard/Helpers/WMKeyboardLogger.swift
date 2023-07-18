//
//  WMKeyboardLogger.swift
//  WebimKeyboard
//
//  Created by Аслан Кутумбаев on 02.06.2023.
//
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation

protocol WMLoggerProtocol {
    var availableLogLevel: LogLevel { get }
    func log(_ message: String, level: LogLevel)
    func set(availableLogLevel: LogLevel)
}

///Instance of this class responseible for logging.
public class WMKeyboardLogger: WMLoggerProtocol {
    
    public static let shared = WMKeyboardLogger()
    
    let bundleIdentifier: String
    var availableLogLevel: LogLevel
    
    private static var currentLogLevel: LogLevel {
        guard let rawValue = UserDefaults.standard.string(forKey: LogLevel.userDefaultsKey) else {
            return .verbose
        }
        return LogLevel(rawValue: rawValue) ?? .verbose
    }
    
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .medium
        dateFormatter.timeZone = .none
        return dateFormatter
    }
    
    private init(bundleIdentifier: String? = Bundle.main.bundleIdentifier, logLevel: LogLevel = currentLogLevel) {
        self.bundleIdentifier = bundleIdentifier ?? "Unknown_Bundle_Identifier"
        self.availableLogLevel = logLevel
        self.set(availableLogLevel: logLevel)
    }
    
    /**
     Set's log type that can be logged.
     - Parameter availableLogLevel: Log type that can be logged. Default value is `verbose`.
     */
    public func set(availableLogLevel: LogLevel = .verbose) {
        self.availableLogLevel = availableLogLevel
        UserDefaults.standard.set(availableLogLevel.rawValue, forKey: LogLevel.userDefaultsKey)
    }
    
    func log(_ message: String, level: LogLevel = .verbose) {
        guard canLog(level: level) else { return }
        
        let currentDate = dateFormatter.string(from: Date())
        let logLevel = level.rawValue
        print("\(bundleIdentifier) || \(currentDate) || \(logLevel) || \(message)")
    }
    
    private func canLog(level: LogLevel) -> Bool {
        switch availableLogLevel {
        case .verbose:
            return level.isVerbose
        case .debug:
            return level.isDebug
        case .info:
            return level.isInfo
        case .warning:
            return level.isWarning
        case .error:
            return level.isError
        }
    }
}
