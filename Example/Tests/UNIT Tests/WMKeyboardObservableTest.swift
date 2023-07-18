//
//  WMKeyboardObservableTest.swift
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

final class WMKeyboardObservableTest: XCTestCase {
    
    var sut = createSUT()
    
    override func setUp() {
        super.setUp()
        sut.subscribed = nil
        sut.shown = nil
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func testSubscribeOnKeyboardNotification() {
        
        sut.subscribeOnKeyboardNotifications()
        
        XCTAssertNotNil(sut.subscribed)
        XCTAssertTrue(sut.subscribed!)
    }

    func testUnsubscribeFromKeyboardNotifications() {
        sut.subscribed = true
        
        sut.unsubscribeFromKeyboardNotifications()
        
        XCTAssertNotNil(sut.subscribed)
        XCTAssertFalse(sut.subscribed!)
    }
    
    func testReceivingKeyboardWillShowNotification() {
        let keyboardInfo = Notification(name: UIResponder.keyboardWillShowNotification).keyboardInfo
        
        sut.subscribeOnKeyboardNotifications()
        sut.keyboardWillShow(keyboardInfo: keyboardInfo)
        
        XCTAssertNotNil(sut.shown)
        XCTAssertTrue(sut.shown!)
    }
    
    func testReceivingKeyboardWillHideNotification() {
        let keyboardInfo = Notification(name: UIResponder.keyboardWillHideNotification).keyboardInfo
        
        sut.subscribeOnKeyboardNotifications()
        sut.keyboardWillHide(keyboardInfo: keyboardInfo)
        
        XCTAssertNotNil(sut.shown)
        XCTAssertFalse(sut.shown!)
    }
}

fileprivate func createSUT() -> WMKeyboardObservableMock {
    return WMKeyboardObservableMock()
}
