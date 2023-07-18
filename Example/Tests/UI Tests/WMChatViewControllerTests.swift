//
//  WMChatViewControllerTests.swift
//  WebimKeyboard_ExampleUITests
//
//  Created by Аслан Кутумбаев on 29.05.2023.
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

final class WMChatViewControllerTests: XCTestCase {
    
    var app = XCUIApplication()
    
    var tableView: XCUIElement {
        app.tables["tableView"]
    }
    
    var textView: XCUIElement {
        app.textViews["inputTextView"]
    }
    
    var sendButton: XCUIElement {
        app.buttons["sendMessageButton"]
    }
    
    override func setUp() {
        app.launch()
        app.buttons["Start"].tap()
    }
    
    override func tearDown() {
        app.terminate()
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    
    func testLastCellHittable_InitialState() {
        XCTAssertTrue(tableView.lastCell.isHittable)
    }

    func testLastCellHittable_WhenShowKeyboard() {
        textView.tap()
        tableView.swipeUp(velocity: .fastest)
        
        XCTAssertTrue(tableView.lastCell.isHittable)
    }
    
    func testLastCellHittable_WhenShowThenHideKeyboard() {
        textView.tap()
        tableView.swipeUp(velocity: .fastest)
        tableView.tap()
        
        XCTAssertTrue(tableView.lastCell.isHittable)
    }
    
    func testKeyboardHittable_WhenInteractiveHideKeyboard() {
        textView.tap()
        tableView.swipeDown()
        
        XCTAssertLessThanOrEqual(app.keyboards.count, 0)
    }
    
    func testFirstCellHittable_WhenShowThenHideKeyboard() {
        tableView.swipeDown(velocity: .fast)
        tableView.swipeDown(velocity: .fast)
        textView.tap()
        tableView.tap()
        
        XCTAssertTrue(tableView.firstCell.isHittable)
    }
    
    func testLastCellHittable_WhenShowThenHideAlert() {
        textView.tap()
        textView.typeText("showAlert")
        sendButton.tap()
        app.alerts["Alert"].buttons["Ok"].tap()
        
        XCTAssertTrue(tableView.lastCell.isHittable)
    }
    
    func testKeyboardStateActive_WhenShowThenHideAlert() {
        textView.tap()
        textView.typeText("showAlert")
        sendButton.tap()
        app.alerts["Alert"].buttons["Ok"].tap()
        
        XCTAssertGreaterThan(app.keyboards.count, 0)
    }
    
    func testKeyboardStateInactive_WhenShowThenHideAlert() {
        textView.tap()
        textView.typeText("showAlert")
        tableView.lastCell.tap()
        sendButton.tap()
        app.alerts["Alert"].buttons["Ok"].tap()
        
        XCTAssertEqual(app.keyboards.count, 0)
    }
    
    func testOverlap_inputTextViewIncreased() {
        textView.tap()
        textView.typeText(multilineText)
        
        XCTAssertTrue(tableView.lastCell.isHittable)
    }
    
    func testOverlap_inputTextViewIncreasedThenDecreased() {
        textView.tap()
        textView.typeText(multilineText)
        textView.clearText()
        
        XCTAssertTrue(tableView.lastCell.isHittable)
    }
    
    func testMaxHeightOfInputTextView() {
        textView.tap()
        textView.typeText(multilineText)
        
        XCTAssertLessThanOrEqual(textView.accessibilityFrame.height, WMNewMessageConstants.maxHeight)
    }
    
    func testScrollViewOffset_AppWillEnterBackgroundThenForeground() {
        textView.tap()
        
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        springboard.activate()
        
        app.activate()
        
        XCTAssertTrue(tableView.lastCell.isHittable)
    }
    
    func testKeyboardStateActive_AppWillEnterBackgroundThenForeground() {
        textView.tap()
        
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        springboard.activate()
        
        app.activate()
        
        XCTAssertGreaterThan(app.keyboards.count, 0)
    }
    
    func testKeyboardStateInactive_AppWillEnterBackgroundThenForeground() {
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        springboard.activate()
        
        app.activate()
        
        XCTAssertLessThanOrEqual(app.keyboards.count, 0)
    }
    
    func testLastCellHittable_WhenPushThenPopVC() {
        textView.tap()
        textView.typeText("pushVC")
        
        sendButton.tap()
        app.buttons["Back"].tap()
        
        XCTAssertTrue(tableView.lastCell.isHittable)
    }
    
    func testKeyboardStateActive_WhenPushThenPopVC() {
        textView.tap()
        textView.typeText("pushVC")
        
        sendButton.tap()
        app.buttons["Back"].tap()
        
        XCTAssertEqual(app.keyboards.count, 0)
    }
    
    func testKeyboardStateInactive_WhenPushThenPopVC() {
        textView.tap()
        textView.typeText("pushVC")
        tableView.lastCell.tap()
        
        sendButton.tap()
        app.buttons["Back"].tap()
        
        XCTAssertEqual(app.keyboards.count, 0)
    }
    
    func testLastCellHittable_WhenVCWasPushed() {
        textView.tap()
        textView.typeText("pushChat")
        tableView.lastCell.tap()
        
        sendButton.tap()
        
        XCTAssertTrue(tableView.lastCell.isHittable)
    }
    
    func testFirstCellHittable_WhenPresentVCAndDismissWithoutAnimation_KeyboardStateInactive() {
        tableView.swipeDown(velocity: .fast)
        tableView.swipeDown(velocity: .fast)
        
        textView.tap()
        textView.typeText("presentVC")
        tableView.tap()
        sendButton.tap()
        
        XCTAssertTrue(tableView.firstCell.isHittable)
    }
}


fileprivate var multilineText: String {
"""
awdawd
awdawfaw
awdawfaw
largeTextlargeTextlargeTextlargeText
largeTextlargeTextlargeTextlargeText
largeTextlargeTextlargeTextlargeText
largeTextlargeTextlargeTextlargeText
"""
}
