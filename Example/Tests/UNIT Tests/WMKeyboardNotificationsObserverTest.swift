//
//  WMKeyboardNotificationsObserverTest.swift
//  WebimKeyboard_Tests
//
//  Created by Аслан Кутумбаев on 26.05.2023.
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

final class WMKeyboardNotificationsObserverTest: XCTestCase {
    
    func testIsObserverInvalidWhenViewDellocated() {
        let sut = createSUT()
        
        XCTAssertTrue(sut.isInvalid)
    }
    
    func testIsObserverValidWhenRefferenceExist() {
        let view = WMKeyboardObservableMock()
        
        let sut = WMKeyboardNotificationsObserver(view: view)

        XCTAssertFalse(sut.isInvalid)
    }
    
    func testObserverLinkedToCorrectView() {
        let view = WMKeyboardObservableMock()
        
        let sut = WMKeyboardNotificationsObserver(view: view)
        
        XCTAssertTrue(sut.isLinked(to: view))
    }
    
    func testObserverLinkedToWrongView() {
        let firstView = WMKeyboardObservableMock()
        let secondView = WMKeyboardObservableMock()
        
        let sut = WMKeyboardNotificationsObserver(view: firstView)
        
        XCTAssertFalse(sut.isLinked(to: secondView))
    }
    
    func testKeyboardWillShowNotification() {
        let sut = createSUT()
        
        sut.keyboardWillShow(notification: createDefaultNotification())
        
        XCTAssertTrue(sut.isKeyboardWillShow)
    }
    
    func testKeyboardWillHideNotification() {
        let sut = createSUT()
        
        sut.keyboardWillHide(notification: createDefaultNotification())
        
        XCTAssertTrue(sut.isKeyboardWillHide)
    }
    
    func testKeyboardDidShowNotification() {
        let sut = createSUT()
        
        sut.keyboardDidShow(notification: createDefaultNotification())
        
        XCTAssertTrue(sut.isKeyboardDidShow)
    }
    
    func testKeyboardDidHideNotification() {
        let sut = createSUT()
        
        sut.keyboardDidHide(notification: createDefaultNotification())
        
        XCTAssertTrue(sut.isKeyboardDidHide)
    }
    
}

fileprivate func createDefaultNotification() -> Notification {
    return Notification(name: UIResponder.keyboardWillShowNotification)
}

fileprivate func createSUT() -> WMKeyboardNotificationsObserverMock {
    let view = WMKeyboardObservableMock()
    return WMKeyboardNotificationsObserverMock(view: view)
}
