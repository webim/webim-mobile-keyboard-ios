//
//  WMKeyboardLoggerTests.swift
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

import XCTest
@testable import WebimKeyboard

class WMKeyboardLoggerTests: XCTestCase {
        
    var logger: WMLoggerMock!

    override func setUpWithError() throws {
        logger = WMLoggerMock()
    }

    override func tearDownWithError() throws {
        logger = nil
    }

    func testLogger_VerboseMessage() {
        let expectedMessage = "Test message"
        
        logger.log(expectedMessage, level: .verbose)
        
        XCTAssertEqual(logger.verboseLogLevelContainer.count, 1)
    }
    
    func testLogger_DebugMessage() {
        let expectedMessage = "Test message"
        
        logger.log(expectedMessage, level: .debug)
        
        XCTAssertEqual(logger.debugLogLevelContainer.count, 1)
    }
    
    func testLogger_InfoMessage() {
        let expectedMessage = "Test message"
        
        logger.log(expectedMessage, level: .info)

        XCTAssertEqual(logger.infoLogLevelContainer.count, 1)
    
    }
    
    func testLogger_WarningMessage() {
        let expectedMessage = "Test message"
        
        logger.log(expectedMessage, level: .warning)

        XCTAssertEqual(logger.warningLogLevelContainer.count, 1)
    }
    
    func testLogger_ErrorMessage() {
        let expectedMessage = "Test message"
        
        logger.log(expectedMessage, level: .error)
        
        XCTAssertEqual(logger.errorLogLevelContainer.count, 1)
    }
    
    func testLogger_VerboseLevelLoggedWhileVerboseLevelSetted() {
        let expectedMessage = "Test message"
        
        logger.set(availableLogLevel: .verbose)
        logger.log(expectedMessage, level: .verbose)
        
        XCTAssertEqual(logger.verboseLogLevelContainer.count, 1)
    }
    
    func testLogger_VerboseLevelNotLoggedWhileDebugLevelSetted() {
        let expectedMessage = "Test message"
        
        logger.set(availableLogLevel: .debug)
        logger.log(expectedMessage, level: .verbose)
        
        XCTAssertEqual(logger.verboseLogLevelContainer.count, 0)
    }
    
    func testLogger_VerboseLevelNotLoggedWhileInfoLevelSetted() {
        let expectedMessage = "Test message"
        
        logger.set(availableLogLevel: .info)
        logger.log(expectedMessage, level: .verbose)
        
        XCTAssertEqual(logger.verboseLogLevelContainer.count, 0)
    }
    
    
    func testLogger_VerboseLevelNotLoggedWhileWarningLevelSetted() {
        let expectedMessage = "Test message"
        
        logger.set(availableLogLevel: .warning)
        logger.log(expectedMessage, level: .verbose)
        
        XCTAssertEqual(logger.verboseLogLevelContainer.count, 0)
    }
    
    func testLogger_VerboseLevelNotLoggedWhileErrorLevelSetted() {
        let expectedMessage = "Test message"
        
        logger.set(availableLogLevel: .error)
        logger.log(expectedMessage, level: .verbose)
        
        XCTAssertEqual(logger.verboseLogLevelContainer.count, 0)
    }
    
    func testLogger_DebugLevelLoggedWhileVerboseLevelSetted() {
        let expectedMessage = "Test message"
        
        logger.set(availableLogLevel: .verbose)
        logger.log(expectedMessage, level: .debug)
        
        XCTAssertEqual(logger.debugLogLevelContainer.count, 1)
    }
    
    func testLogger_DebugLevelLoggedWhileDebugLevelSetted() {
        let expectedMessage = "Test message"
        
        logger.set(availableLogLevel: .debug)
        logger.log(expectedMessage, level: .debug)
        
        XCTAssertEqual(logger.debugLogLevelContainer.count, 1)
    }
    
    
    func testLogger_DebugLevelNotLoggedWhileInfoLevelSetted() {
        let expectedMessage = "Test message"
        
        logger.set(availableLogLevel: .info)
        logger.log(expectedMessage, level: .debug)
        
        XCTAssertEqual(logger.debugLogLevelContainer.count, 0)
    }
    
    func testLogger_DebugLevelNotLoggedWhileWarningLevelSetted() {
        let expectedMessage = "Test message"
        
        logger.set(availableLogLevel: .warning)
        logger.log(expectedMessage, level: .debug)
        
        XCTAssertEqual(logger.debugLogLevelContainer.count, 0)
    }
    
    func testLogger_DebugLevelNotLoggedWhileErrorLevelSetted() {
        let expectedMessage = "Test message"
        
        logger.set(availableLogLevel: .error)
        logger.log(expectedMessage, level: .debug)
        
        XCTAssertEqual(logger.debugLogLevelContainer.count, 0)
    }
    
    func testLogger_InfoLevelLoggedWhileVerboseLevelSetted() {
        let expectedMessage = "Test message"
        
        logger.set(availableLogLevel: .verbose)
        logger.log(expectedMessage, level: .info)
        
        XCTAssertEqual(logger.infoLogLevelContainer.count, 1)
    }
    
    func testLogger_InfoLevelLoggedWhileDebugLevelSetted() {
        let expectedMessage = "Test message"
        
        logger.set(availableLogLevel: .debug)
        logger.log(expectedMessage, level: .info)
        
        XCTAssertEqual(logger.infoLogLevelContainer.count, 1)
    }
    
    func testLogger_InfoLevelLoggedWhileInfoLevelSetted() {
        let expectedMessage = "Test message"
        
        logger.set(availableLogLevel: .info)
        logger.log(expectedMessage, level: .info)
        
        XCTAssertEqual(logger.infoLogLevelContainer.count, 1)
    }
    
    func testLogger_InfoLevelNotLoggedWhileWarningLevelSetted() {
        let expectedMessage = "Test message"
        
        logger.set(availableLogLevel: .warning)
        logger.log(expectedMessage, level: .info)
        
        XCTAssertEqual(logger.infoLogLevelContainer.count, 0)
    }
    
    func testLogger_InfoLevelNotLoggedWhileErrorLevelSetted() {
        let expectedMessage = "Test message"
        
        logger.set(availableLogLevel: .error)
        logger.log(expectedMessage, level: .info)
        
        XCTAssertEqual(logger.infoLogLevelContainer.count, 0)
    }
    
    func testLogger_WarningLevelLoggedWhileVerboseLevelSetted() {
        let expectedMessage = "Test message"
        
        logger.set(availableLogLevel: .verbose)
        logger.log(expectedMessage, level: .warning)
        
        XCTAssertEqual(logger.warningLogLevelContainer.count, 1)
    }
    
    func testLogger_WarningLevelLoggedWhileDebugLevelSetted() {
        let expectedMessage = "Test message"
        
        logger.set(availableLogLevel: .debug)
        logger.log(expectedMessage, level: .warning)
        
        XCTAssertEqual(logger.warningLogLevelContainer.count, 1)
    }
    
    func testLogger_WarningLevelLoggedWhileInfoLevelSetted() {
        let expectedMessage = "Test message"
        
        logger.set(availableLogLevel: .info)
        logger.log(expectedMessage, level: .warning)
        
        XCTAssertEqual(logger.warningLogLevelContainer.count, 1)
    }
    
    func testLogger_WarningLevelLoggedWhileWarningLevelSetted() {
        let expectedMessage = "Test message"
        
        logger.set(availableLogLevel: .warning)
        logger.log(expectedMessage, level: .warning)
        
        XCTAssertEqual(logger.warningLogLevelContainer.count, 1)
    }
    
    func testLogger_WarningLevelNotLoggedWhileErrorLevelSetted() {
        let expectedMessage = "Test message"
        
        logger.set(availableLogLevel: .error)
        logger.log(expectedMessage, level: .warning)
        
        XCTAssertEqual(logger.warningLogLevelContainer.count, 0)
    }
    
    func testLogger_ErrorLevelLoggedWhileVerboseLevelSetted() {
        let expectedMessage = "Test message"
        
        logger.set(availableLogLevel: .verbose)
        logger.log(expectedMessage, level: .error)
        
        XCTAssertEqual(logger.errorLogLevelContainer.count, 1)
    }
    
    func testLogger_ErrorLevelLoggedWhileDebugLevelSetted() {
        let expectedMessage = "Test message"
        
        logger.set(availableLogLevel: .debug)
        logger.log(expectedMessage, level: .error)
        
        XCTAssertEqual(logger.errorLogLevelContainer.count, 1)
    }
    
    func testLogger_ErrorLevelLoggedWhileInfoLevelSetted() {
        let expectedMessage = "Test message"
        
        logger.set(availableLogLevel: .info)
        logger.log(expectedMessage, level: .error)
        
        XCTAssertEqual(logger.errorLogLevelContainer.count, 1)
    }
    
    func testLogger_ErrorLevelLoggedWhileWarningLevelSetted() {
        let expectedMessage = "Test message"
        
        logger.set(availableLogLevel: .warning)
        logger.log(expectedMessage, level: .error)
        
        XCTAssertEqual(logger.errorLogLevelContainer.count, 1)
    }
    
    func testLogger_ErrorLevelLoggedWhileErrorLevelSetted() {
        let expectedMessage = "Test message"
        
        logger.set(availableLogLevel: .error)
        logger.log(expectedMessage, level: .error)
        
        XCTAssertEqual(logger.errorLogLevelContainer.count, 1)
    }
    

    func testLogger_IsVerboseLevelIncludeAnotherMessages() {
        let expectedMessage = "Test verbose message"

        logger.log(expectedMessage, level: .verbose)

        XCTAssertEqual(logger.verboseLogLevelContainer.count, 1)
        XCTAssertEqual(logger.debugLogLevelContainer.count, 1)
        XCTAssertEqual(logger.infoLogLevelContainer.count, 1)
        XCTAssertEqual(logger.warningLogLevelContainer.count, 1)
        XCTAssertEqual(logger.errorLogLevelContainer.count, 1)
    }
    
    func testLogger_IsDebugLevelIncludeAnotherMessages() {
        let expectedMessage = "Test debug message"

        logger.log(expectedMessage, level: .debug)

        XCTAssertEqual(logger.verboseLogLevelContainer.count, 0)
        XCTAssertEqual(logger.debugLogLevelContainer.count, 1)
        XCTAssertEqual(logger.infoLogLevelContainer.count, 1)
        XCTAssertEqual(logger.warningLogLevelContainer.count, 1)
        XCTAssertEqual(logger.errorLogLevelContainer.count, 1)
    }
    
    func testLogger_IsInfoLevelIncludeAnotherMessages() {
        let expectedMessage = "Test info message"

        logger.log(expectedMessage, level: .info)

        XCTAssertEqual(logger.verboseLogLevelContainer.count, 0)
        XCTAssertEqual(logger.debugLogLevelContainer.count, 0)
        XCTAssertEqual(logger.infoLogLevelContainer.count, 1)
        XCTAssertEqual(logger.warningLogLevelContainer.count, 1)
        XCTAssertEqual(logger.errorLogLevelContainer.count, 1)
    }
    
    func testLogger_IsWarningLevelIncludeAnotherMessages() {
        let expectedMessage = "Test warning message"

        logger.log(expectedMessage, level: .warning)

        XCTAssertEqual(logger.verboseLogLevelContainer.count, 0)
        XCTAssertEqual(logger.debugLogLevelContainer.count, 0)
        XCTAssertEqual(logger.infoLogLevelContainer.count, 0)
        XCTAssertEqual(logger.warningLogLevelContainer.count, 1)
        XCTAssertEqual(logger.errorLogLevelContainer.count, 1)
    }
    
    func testLogger_IsErrorLevelIncludeAnotherMessages() {
        let expectedMessage = "Test error message"

        logger.log(expectedMessage, level: .error)

        XCTAssertEqual(logger.verboseLogLevelContainer.count, 0)
        XCTAssertEqual(logger.debugLogLevelContainer.count, 0)
        XCTAssertEqual(logger.infoLogLevelContainer.count, 0)
        XCTAssertEqual(logger.warningLogLevelContainer.count, 0)
        XCTAssertEqual(logger.errorLogLevelContainer.count, 1)
    }
    
    func testLogger_LastVerboseLevelSaved() {
        let logger = WMKeyboardLogger.shared
        let expectedValue = LogLevel.error
        
        logger.set(availableLogLevel: expectedValue)
        
        XCTAssertEqual(expectedValue.rawValue, UserDefaults.standard.string(forKey: LogLevel.userDefaultsKey) ?? "")
    }
}
