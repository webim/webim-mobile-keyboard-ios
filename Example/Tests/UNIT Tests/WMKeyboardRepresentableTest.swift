//
//  WMKeyboardRepresentableTest.swift
//  WebimKeyboard_Tests
//
//  Created by Аслан Кутумбаев on 24.05.2023.
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

final class WMKeyboardRepresentableTest: XCTestCase {
    
    var sut = createSUT()
    
    override func tearDown() {
        sut.keyboardInfo = nil
    }
    
    func testValidKeyboardWillShowNotification() {
        let expectedValue = UIResponder.keyboardWillShowNotification
        let keyboardInfo = Notification(
            name: expectedValue,
            object: nil,
            userInfo: [:]
        ).keyboardInfo
        
        sut.keyboardWillShow(keyboardInfo: keyboardInfo)
        
        XCTAssertNotNil(sut.keyboardInfo)
        XCTAssertEqual(keyboardInfo.name, expectedValue)
    }
    
    func testValidKeyboardWillHideNotification() {
        let expectedValue = UIResponder.keyboardWillHideNotification
        let keyboardInfo = Notification(
            name: expectedValue,
            object: nil,
            userInfo: [:]
        ).keyboardInfo
        
        sut.keyboardWillHide(keyboardInfo: keyboardInfo)
        
        XCTAssertNotNil(sut.keyboardInfo)
        XCTAssertEqual(keyboardInfo.name, expectedValue)
    }
    
    func testValidKeyboardDidShowNotification() {
        let expectedValue = UIResponder.keyboardDidShowNotification
        let keyboardInfo = Notification(
            name: expectedValue,
            object: nil,
            userInfo: [:]
        ).keyboardInfo
        
        sut.keyboardDidShow(keyboardInfo: keyboardInfo)
        
        XCTAssertNotNil(sut.keyboardInfo)
        XCTAssertEqual(keyboardInfo.name, expectedValue)
    }
    
    func testValidKeyboardDidHideNotification() {
        let expectedValue = UIResponder.keyboardDidHideNotification
        let keyboardInfo = Notification(
            name: expectedValue,
            object: nil,
            userInfo: [:]
        ).keyboardInfo
        
        sut.keyboardDidHide(keyboardInfo: keyboardInfo)
        
        XCTAssertNotNil(sut.keyboardInfo)
        XCTAssertEqual(keyboardInfo.name, expectedValue)
    }
}

fileprivate func createSUT() -> WMKeyboardRepresentableMock {
    return WMKeyboardRepresentableMock()
}
