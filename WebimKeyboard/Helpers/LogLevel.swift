//
//  LogLevel.swift
//  WebimKeyboard
//
//  Created by Аслан Кутумбаев on 28.06.2023.
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

/**
    Represents the different log levels for logging messages.
 
    The LogLevel enum defines different log levels, including verbose, debug, info, warning, and error.
 */
public enum LogLevel: String {
    /**
        Verbose log level.
     
        This log level is used for detailed and extensive logging, typically used during development and debugging.
     */
    case verbose = "[VERBOSE]"
    
    /**
        Debug log level.
     
        This log level is used for debugging purposes to log detailed information during development.
     */
    case debug = "[DEBUG]"
    
    /**
        Information log level.
     
        This log level is used to provide general information about the program's execution.
     */
    case info = "[INFO]"
    
    /**
        Warning log level.
     
        This log level is used to indicate potential issues or situations that might need attention.
     */
    case warning = "[WARNING]"
    
    /**
        Error log level.
     
        This log level is used to indicate errors or critical issues that require immediate attention.
     */
    case error = "[ERROR]"
    
    /**
        The key used to store the log level in the UserDefaults.
     
        This static constant provides the key string used to store the log level in the UserDefaults.
     */
    static let userDefaultsKey: String = "LogLevelKey"
}


extension LogLevel {
    var isVerbose: Bool {
        return true
    }
    
    var isDebug: Bool {
        return self == .debug || self == .info || self == .warning || self == .error
    }
    
    var isInfo: Bool {
        return self == .info || self == .warning || self == .error
    }
    
    var isWarning: Bool {
        return self == .warning || self == .error
    }
    
    var isError: Bool {
        return self == .error
    }

}
