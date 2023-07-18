//
//  WMkeyboardManagerProtocol.swift
//  WebimKeyboard
//
//  Created by Аслан Кутумбаев on 28.06.2023.
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
    The protocol for managing keyboard-related events and actions.
 
    The WMKeyboardManagerProtocol protocol defines methods and properties that a conforming object should implement to handle keyboard events and interact with a keyboard manager delegate.
 */
public protocol WMKeyboardManagerProtocol {
    /**
        The delegate object for the keyboard manager.
     
        This property represents the delegate object that will handle keyboard events and actions.
     */
    var delegate: WMKeyboardManagerDelegate? { get set }
    
    /**
        Adjusts the keyboard notification based on the keyboard information and notification kind.
     
        This method is called to adjust the keyboard notification based on the provided keyboard information and notification kind. The implementation should handle any necessary adjustments related to the keyboard, such as updating the scroll view's content offset and content inset.
     
     - Parameters:
            - keyboardInfo: The keyboard information containing details about the keyboard, such as its frame and animation duration.
            - kind: The kind of keyboard notification, such as keyboard will show, keyboard did show, keyboard will hide, or keyboard did hide.
     */
    func adjustKeyboardNotification(_ keyboardInfo: Notification.KeyboardInfo, kind: Notification.Kind)
}
