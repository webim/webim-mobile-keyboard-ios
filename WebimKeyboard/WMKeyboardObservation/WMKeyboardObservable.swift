//
//  WMKeyboardObservable.swift
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
The WMKeyboardObservable protocol defines the interface for objects that need to observe keyboard notifications.
 
 Objects conforming to this protocol can subscribe to keyboard notifications, unsubscribe from keyboard notifications, and handle different keyboard events such as keyboard will show, keyboard will hide, keyboard did show, and keyboard did hide.
 */
public protocol WMKeyboardObservable: AnyObject {
    /**
        Subscribes to keyboard notifications.
     
        This method allows the conforming object to subscribe to keyboard notifications and start receiving keyboard-related events.
     
        This method has default implementation.
    */
    func subscribeOnKeyboardNotifications()

    /**
        Unsubscribes from keyboard notifications.
     
        This method allows the conforming object to unsubscribe from keyboard notifications and stop receiving keyboard-related events.
    */
    func unsubscribeFromKeyboardNotifications()

    /**
        Handles the keyboard will show event.
     
        This method is called when the keyboard is about to be shown.
     
        This method has default implementation.
     
        - Parameter notification: The notification object containing information about the keyboard.
    */
    func keyboardWillShow(notification: Notification)

    /**
        Handles the keyboard will hide event.
     
        This method is called when the keyboard is about to be hidden.
     
        - Parameter notification: The notification object containing information about the keyboard.
    */
    func keyboardWillHide(notification: Notification)

    /**
        Handles the keyboard did show event.
     
        This method is called when the keyboard has been shown.
     
        This method has empty default implementation.
     
        - Parameter notification: The notification object containing information about the keyboard.
    */
    func keyboardDidShow(notification: Notification)

    /**
        Handles the keyboard did hide event.
     
        This method is called when the keyboard has been hidden.
     
        This method has empty default implementation.
     
        - Parameter notification: The notification object containing information about the keyboard.
    */
    func keyboardDidHide(notification: Notification)
}

public extension WMKeyboardObservable {

    // MARK: - Public Methods
    func subscribeOnKeyboardNotifications() {
        WMKeyboardLogger.shared.log("Subscribing for keyboard notifications", level: .debug)
        guard let notificationsObserver = WMKeyboardNotificationsObserverContainer.shared.newObserver(for: self) else {
            WMKeyboardLogger.shared.log("This view already subscribed on notifications", level: .debug)
            return
        }
        let center = NotificationCenter.default
        WMKeyboardLogger.shared.log("Adding observer for keyboardWillShow notification", level: .debug)
        center.addObserver(notificationsObserver,
                           selector: #selector(WMKeyboardNotificationsObserver.keyboardWillShow(notification:)),
                           name: UIResponder.keyboardWillShowNotification,
                           object: nil)
        WMKeyboardLogger.shared.log("Adding observer for keyboardWillHide notification", level: .debug)
        center.addObserver(notificationsObserver,
                           selector: #selector(WMKeyboardNotificationsObserver.keyboardWillHide(notification:)),
                           name: UIResponder.keyboardWillHideNotification,
                           object: nil)
        WMKeyboardLogger.shared.log("Adding observer for keyboardDidShow notification", level: .debug)
        center.addObserver(notificationsObserver,
                           selector: #selector(WMKeyboardNotificationsObserver.keyboardDidShow(notification:)),
                           name: UIResponder.keyboardDidShowNotification,
                           object: nil)
        WMKeyboardLogger.shared.log("Adding observer for keyboardDidHide notification", level: .debug)
        center.addObserver(notificationsObserver,
                           selector: #selector(WMKeyboardNotificationsObserver.keyboardDidHide(notification:)),
                           name: UIResponder.keyboardDidHideNotification,
                           object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {
        WMKeyboardLogger.shared.log("Unsubscribing from keyboard notifications", level: .debug)
        WMKeyboardNotificationsObserverContainer.shared.removeInvalid()
        WMKeyboardNotificationsObserverContainer.shared.releaseObserver(for: self)
    }
}

public extension WMKeyboardObservable {
    // MARK: - Optional Methods
    func keyboardDidShow(notification: Notification) { }
    func keyboardDidHide(notification: Notification) { }
}
