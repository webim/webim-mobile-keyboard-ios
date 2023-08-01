//
//  WMKeyboardManager.swift
//  WebimKeyboard
//
//  Created by Аслан Кутумбаев on 29.05.2023.
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
import UIKit

/**
    A manager class for handling keyboard-related events and actions.
 
    The `WMKeyboardManager` class implements the `WMKeyboardManagerProtocol` protocol and provides functionality for adjusting the keyboard notification and managing the associated scroll view's content offset and content inset.
 */
public class WMKeyboardManager: WMKeyboardManagerProtocol {
    public weak var delegate: WMKeyboardManagerDelegate?
    
    public init() { }
    
    public func adjustKeyboardNotification(_ keyboardInfo: Notification.KeyboardInfo, kind: Notification.Kind) {
        WMKeyboardLogger.shared.log("WMKeyboardManager start handle \(kind) notification with keyboardInfo: \(keyboardInfo)", level: .debug)
        
        guard let scrollViewModel = delegate?.scrollViewModel else {
            WMKeyboardLogger.shared.log("WMKeyboardManager.delegate doesn't exist. You must to set this property!", level: .error)
            fatalError("You must to set delegate property!")
        }
        
        WMKeyboardLogger.shared.log("ScrollViewModel counted - \(scrollViewModel)", level: .verbose)
        
        guard delegate?.presented != true else {
            WMKeyboardLogger.shared.log("Notification \(keyboardInfo) was skipped, because view start's presenting another view.", level: .info)
            return
        }
        
        let keyboardInfo = handleKeyboardWillHideNotification(
            keybordInfo: keyboardInfo,
            toolbarHeight: scrollViewModel.toolbarViewHeight,
            kind: kind
        )
        
        setContentInset(keyboardInfo: keyboardInfo)
        
        let delta = (keyboardInfo.frameEnd?.height ?? 0) - (keyboardInfo.frameBegin?.height ?? 0)
        WMKeyboardLogger.shared.log("Delta counted - \(delta)", level: .verbose)

        // This skip prevent extra scroll.
        if isExtraNotification(keyboardInfo: keyboardInfo, scrollViewModel: scrollViewModel, kind: kind) {
            WMKeyboardLogger.shared.log("Extra notification detected in \(#function). Notification - \(keyboardInfo)", level: .info)
            return
        }
        
        setContentOffset(keyboardInfo: keyboardInfo, scrollViewModel: scrollViewModel, delta: delta)
    }
    
    /**
     Set's contentInset according to keyboardInfo.
     
     - Parameter keyboardInfo: The keyboard information containing details about the keyboard, such as its frame and animation duration.
     */
    private func setContentInset(keyboardInfo: Notification.KeyboardInfo) {
        UIView.animate(withDuration: keyboardInfo.animationDuration!) { [weak self] in
            guard let self = self else { return }
            let contentInset = keyboardInfo.frameEnd?.height ?? 0
            WMKeyboardLogger.shared.log("Start setting contentInset for associated scrollView. ContentInset - \(contentInset)", level: .info)
            self.delegate?.set(contentInset: contentInset)
            self.delegate?.layoutIfNeeded()
        }
    }
    
    /**
     Set's contentOffset according to keyboardInfo.
     
     - Parameter keyboardInfo: The keyboard information containing details about the keyboard, such as its frame and animation duration.
     */
    private func setContentOffset(keyboardInfo: Notification.KeyboardInfo, scrollViewModel: WMScrollViewModel, delta: CGFloat) {
        UIView.animate(withDuration: keyboardInfo.animationDuration!) { [weak self] in
            guard let self = self else { return }
            let contentOffset = (scrollViewModel.scrollViewContentOffset) + delta
            WMKeyboardLogger.shared.log("Start setting contentOffset for associated scrollView. ContentOffset - \(contentOffset)", level: .info)
            self.delegate?.set(contentOffset: contentOffset)
            self.delegate?.layoutIfNeeded()
        }
    }
    
    /**
        Checks if the keyboard notification is an extra notification.
     
        This method checks if the provided keyboard notification is an extra notification that should be skipped. It takes into account various conditions, such as the equality of keyboard height and toolbar height, restricted animation duration, and notification after switching apps.
     
        - Parameter keyboardInfo: The keyboard information containing details about the keyboard, such as its frame and animation duration.
        - Parameter scrollViewModel: The scroll view model associated with the keyboard manager.
        - Parameter kind: The kind of keyboard notification, such as keyboard will show, keyboard did show, keyboard will hide, or keyboard did hide.
        - Returns: `true` if the keyboard notification is an extra notification and should be skipped, `false` otherwise.
     
        - seealso: `handleKeyboardWillHideNotification`
     */
    private func isExtraNotification(
        keyboardInfo: Notification.KeyboardInfo,
        scrollViewModel: WMScrollViewModel,
        kind: Notification.Kind
    ) -> Bool {
        guard let keyboardHeight = keyboardInfo.frameEnd?.height else { return true }
        let keyboardHeightEqualToolbarHeight = keyboardHeight.isEqual(to: scrollViewModel.toolbarViewHeight, epsilon: 0.1)
        let isRestrictedAnimationDuration = keyboardInfo.animationDuration == .zero ||  keyboardInfo.animationDuration == 0.35
        let isNotificationAfterSwitchApp = keyboardInfo.frameBegin == keyboardInfo.frameEnd
        let finishedNotification = (kind == .keyboardDidShow) || (kind == .keyboardDidHide)
        return (keyboardHeightEqualToolbarHeight && isRestrictedAnimationDuration) || (isNotificationAfterSwitchApp && isRestrictedAnimationDuration) || finishedNotification
    }
    
    /**
        Handles the `keyboardWillHide` notification.
     
        This method replaces the `keyboardWillHide` notification with correct values that include the input accessory view height. It adjusts the frame end of the keyboard information to include the toolbar height and the height delta.
     
        When `inputAccessoryView` exist and keyboard will hide, NotificationCenter emit 2 notifications `keyboardWillHide` and `keyboardWillShow` notifications.
        
        `keyboardWillHide` notification that has frameEnd value exclude `inputAccessoryView` height.
     
        `keyboardWillShow` notification that has frameEnd value include `inputAccessoryView` height.
     
        This method replace `keyboardWillHide` notification with correct values that include `inputAccessoryView` height.
     
        - Parameter keybordInfo: The original keyboard information of the keyboard will hide notification.
        - Parameter toolbarHeight: The height of the toolbar view associated with the keyboard manager.
        - Parameter kind: The kind of keyboard notification, such as keyboard will show, keyboard did show, keyboard will hide, or keyboard did hide.
        - Returns: The updated keyboard information with the adjusted frame end.
     */
    private func handleKeyboardWillHideNotification(
        keybordInfo: Notification.KeyboardInfo,
        toolbarHeight: CGFloat,
        kind: Notification.Kind
    ) -> Notification.KeyboardInfo {
        
        guard kind == .keyboardWillHide else { return keybordInfo }
        
        let frameEnd = CGRect(
            x: keybordInfo.frameEnd?.origin.x ?? 0,
            y: keybordInfo.frameEnd?.origin.y ?? 0,
            width: keybordInfo.frameEnd?.width ?? 0,
            height: toolbarHeight + (keybordInfo.heightDelta ?? 0)
        )
        
        let newKeyboardInfo = Notification.KeyboardInfo(
            name: keybordInfo.name,
            frameBegin: keybordInfo.frameEnd,
            animationCurve: keybordInfo.animationCurve,
            animationDuration: keybordInfo.animationDuration,
            frameEnd: frameEnd
        )
        WMKeyboardLogger.shared.log("\(keybordInfo) was replaced to \(newKeyboardInfo) in \(#function)", level: .info)
        return newKeyboardInfo
    }
}
