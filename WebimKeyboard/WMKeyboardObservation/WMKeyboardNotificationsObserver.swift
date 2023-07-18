//
//  WMKeyboardNotificationsObserver.swift
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
 The WMKeyboardNotificationsObserver class is responsible for observing keyboard notifications
 
 The observer keeps a weak reference to the `WMKeyboardObservable` object and forwards the received keyboard notifications to it.

 - Note: Instances of this class should not be created directly.
 */
class WMKeyboardNotificationsObserver {
    
    // MARK: - Properties
    /**
        Indicates whether the observer is no longer valid.
     
        This property returns `true` if the associated `view` has been deallocated, indicating that the observer is no longer valid and should not be used.
    */
    var isInvalid: Bool {
        return view == nil
    }

    // MARK: - Private Properties
    /// The weak reference to the `WMKeyboardObservable` object.
    private weak var view: WMKeyboardObservable?

    // MARK: - Initialization
    /**
        Initializes the observer with a `WMKeyboardObservable` object.
        - Parameter view: The `WMKeyboardObservable` object to observe.
    */
    init(view: WMKeyboardObservable) {
        self.view = view
    }

    // MARK: - Internal Methods
    /**
        Checks if the observer is linked to a specific `WMKeyboardObservable` object.
        - Parameter view: The `WMKeyboardObservable` object to check.
        - Returns: `true` if the observer is linked to the specified `WMKeyboardObservable` object, `false` otherwise.
    */
    func isLinked(to view: WMKeyboardObservable) -> Bool {
        guard let guardedView = self.view else { return false }
        return guardedView === view
    }

    /**
        Handles the `keyboardWillShow` event.
     
        This method is called when the keyboard is about to be shown.
     
        - Parameter notification: The notification object containing information about the keyboard.
    */
    @objc
    func keyboardWillShow(notification: Notification) {
        WMKeyboardLogger.shared.log("Received notification: \(notification)", level: .info)
        view?.keyboardWillShow(notification: notification)
    }

    /**
        Handles the `keyboardWillHide` event.
     
        This method is called when the keyboard is about to be hidden.
     
        - Parameter notification: The notification object containing information about the keyboard.
    */
    @objc
    func keyboardWillHide(notification: Notification) {
        WMKeyboardLogger.shared.log("Received notification: \(notification)", level: .info)
        view?.keyboardWillHide(notification: notification)
    }

    /**
        Handles the `keyboardDidShow` event.
     
        This method is called when the keyboard has been shown.
     
        - Parameter notification: The notification object containing information about the keyboard.
    */
    @objc
    func keyboardDidShow(notification: Notification) {
        WMKeyboardLogger.shared.log("Received notification: \(notification)", level: .info)
        view?.keyboardDidShow(notification: notification)
    }

    /**
        Handles the `keyboardDidHide` event.
     
        This method is called when the keyboard has been hidden.
     
        - Parameter notification: The notification object containing information about the keyboard.
    */
    @objc
    func keyboardDidHide(notification: Notification) {
        WMKeyboardLogger.shared.log("Received notification: \(notification)", level: .info)
        view?.keyboardDidHide(notification: notification)
    }
}
