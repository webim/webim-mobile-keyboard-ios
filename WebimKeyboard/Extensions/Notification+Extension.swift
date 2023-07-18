//
//  Notification.swift
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

import UIKit

public extension Notification {

    /// Instance of this structure keeps info about keyboard from notification
    struct KeyboardInfo {
        public var name: Name?
        public var frameBegin: CGRect?
        public var animationCurve: UInt?
        public var animationDuration: Double?
        public var frameEnd: CGRect?
        
        public var heightDelta: CGFloat? {
            guard let frameEnd = frameEnd, let frameBegin = frameBegin else { return nil }
            return frameEnd.height - frameBegin.height
        }
    }
    
    /// Instance of this enum keeps infor about keyboard notification kind
    enum Kind {
        case keyboardWillShow
        case keyboardWillHide
        case keyboardDidShow
        case keyboardDidHide
        
        var shown: Bool {
            return self == .keyboardWillShow || self == .keyboardDidShow
        }
    }

    // MARK: - Public Properties
    var keyboardInfo: KeyboardInfo {
        return KeyboardInfo(
            name: name,
            frameBegin: keyboardFrameBegin,
            animationCurve: keyboradAnimationCurve,
            animationDuration: keyboardAnimationDuration,
            frameEnd: keyboardFrameEnd
        )
    }

    // MARK: - Private Properties
    private var keyboardFrameBegin: CGRect? {
        return userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect
    }

    private var keyboradAnimationCurve: UInt? {
        return userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
    }

    private var keyboardAnimationDuration: Double? {
        return userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
    }

    private var keyboardFrameEnd: CGRect? {
        return userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
    }
}
