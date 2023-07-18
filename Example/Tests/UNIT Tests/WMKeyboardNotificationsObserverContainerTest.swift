//
//  WMKeyboardNotificationsObserverContainerTest.swift
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

final class WMKeyboardNotificationsObserverContainerTest: XCTestCase {
    var sut: WMKeyboardNotificationsObserverContainer!
    
    override func setUp() {
        sut = createSUT()
    }
    
    
    func testNewObserverValidForView() {
        let view = WMKeyboardObservableMock()
        
        let newObserver = sut.newObserver(for: view)
        
        XCTAssertNotNil(newObserver)
    }
    
    func testNewObserverInvalidForExistView() {
        let view = WMKeyboardObservableMock()
        
        _ = sut.newObserver(for: view)
        let newObserver = sut.newObserver(for: view)
        
        XCTAssertNil(newObserver)
    }
    
    func testRemoveInvalidObserver() {
        _ = sut.newObserver(for: WMKeyboardObservableMock())
        
        sut.removeInvalid()
        
        XCTAssertTrue(sut.observers.isEmpty)
    }
    
    func testReleaseObserver() {
        let view = WMKeyboardObservableMock()
        
        _ = sut.newObserver(for: view)
        
        sut.releaseObserver(for: view)
        
        XCTAssertTrue(sut.observers.isEmpty)
    }
}


fileprivate func createSUT() -> WMKeyboardNotificationsObserverContainer {
    return WMKeyboardNotificationsObserverContainer()
}
