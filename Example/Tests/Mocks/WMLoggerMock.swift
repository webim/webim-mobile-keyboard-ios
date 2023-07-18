//
//  WMLoggerMock.swift
//  WebimKeyboard_UNIT_Tests
//
//  Created by Аслан Кутумбаев on 02.06.2023.
//  Copyright © 2023 Webim.ru. All rights reserved.
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
@testable import WebimKeyboard

class WMLoggerMock: WMLoggerProtocol {
    var availableLogLevel: LogLevel = .verbose
    
    var verboseLogLevelContainer = [String]()
    var debugLogLevelContainer = [String]()
    var infoLogLevelContainer = [String]()
    var warningLogLevelContainer = [String]()
    var errorLogLevelContainer = [String]()
    
    func set(availableLogLevel: LogLevel) {
        self.availableLogLevel = availableLogLevel
    }
    
    func log(_ message: String, level: LogLevel) {
        guard canLog(level: level) else { return }
        switch level {
        case .verbose:
            verboseLogLevelContainer.append(message)
            debugLogLevelContainer.append(message)
            infoLogLevelContainer.append(message)
            warningLogLevelContainer.append(message)
            errorLogLevelContainer.append(message)
        case .debug:
            debugLogLevelContainer.append(message)
            infoLogLevelContainer.append(message)
            warningLogLevelContainer.append(message)
            errorLogLevelContainer.append(message)
        case .info:
            infoLogLevelContainer.append(message)
            warningLogLevelContainer.append(message)
            errorLogLevelContainer.append(message)
        case .warning:
            warningLogLevelContainer.append(message)
            errorLogLevelContainer.append(message)
        case .error:
            errorLogLevelContainer.append(message)
        }
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
