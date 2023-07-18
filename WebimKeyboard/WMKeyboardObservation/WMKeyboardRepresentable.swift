//
//  WMKeyboardRepresentable.swift
//  WebimKeyboard
//
//  Created by Аслан Кутумбаев on 24.05.2023.
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
 This protocol allows you to get full keyboard parameters on keyboard appear/disappear.
 But you have to use this protocol along with WMKeyboardObservable protocol.
 */
public protocol WMKeyboardRepresentable: AnyObject {

    /// This method is called when the keyboard appears on the device screen
    func keyboardWillShow(keyboardInfo: Notification.KeyboardInfo)

    /// This method is called when the keyboard disappears from the device screen
    func keyboardWillHide(keyboardInfo: Notification.KeyboardInfo)

    /// This method is called after the keyboard appears on the device screen
    func keyboardDidShow(keyboardInfo: Notification.KeyboardInfo)

    /// This method is called after the keyboard disappears from the device screen
    func keyboardDidHide(keyboardInfo: Notification.KeyboardInfo)

}

public extension WMKeyboardRepresentable where Self: WMKeyboardObservable {

    func keyboardWillShow(notification: Notification) {
        keyboardWillShow(keyboardInfo: notification.keyboardInfo)
    }

    func keyboardWillHide(notification: Notification) {
        keyboardWillHide(keyboardInfo: notification.keyboardInfo)
    }

    func keyboardDidShow(notification: Notification) {
        keyboardDidShow(keyboardInfo: notification.keyboardInfo)
    }

    func keyboardDidHide(notification: Notification) {
        keyboardDidHide(keyboardInfo: notification.keyboardInfo)
    }
}

public extension WMKeyboardRepresentable {
    // MARK: - Optional Method
    func keyboardDidShow(keyboardInfo: Notification.KeyboardInfo) { }
    func keyboardDidHide(keyboardInfo: Notification.KeyboardInfo) { }
}
