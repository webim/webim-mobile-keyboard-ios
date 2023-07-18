//
//  WMKeyboardManagerDelegate.swift
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
    The delegate protocol for managing keyboard-related events and actions.
 
    The WMKeyboardManagerDelegate protocol defines methods and properties that a delegate object should implement to handle keyboard events and manage the associated scroll view's content offset and content inset.
 */
public protocol WMKeyboardManagerDelegate: AnyObject {
    /**
        The scroll view model associated with the keyboard manager.
     
        This property represents the current information about scrollView. The keyboard manager interacts with this `scrollViewModel` to manage the content offset and content inset.
     */
    var scrollViewModel: WMScrollViewModel { get }
    
    /**
        A Boolean value indicating whether the view controller is currently presented.
     
        This property indicates whether the view controller associated with the keyboard manager is currently presented or not.
     
        You must to set
        `return presentedViewController != nil`
        to this value.
     */
    var presented: Bool { get }
    
    /**
        Sets the content offset of the associated scroll view.
     
        This method sets the content offset of the associated scroll view to the specified value.
     
        - Parameter contentOffset: The new content offset value to set.
     */
    func set(contentOffset: CGFloat)
    
    /**
        Sets the content inset of the associated scroll view.
     
        This method sets the content inset of the associated scroll view to the specified value.
     
        - Parameter contentInset: The new content inset value to set.
     */
    func set(contentInset: CGFloat)
    
    /**
        Forces the layout update of the associated view.
     
        This method forces the immediate layout update of the associated view to reflect any pending layout changes.
     
        You must to set
        `view.layoutIfNeeded()`
        to this value.
     */
    func layoutIfNeeded()
}
