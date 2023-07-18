//
//  WMNewMessageView.swift
//  WebimKeyboard_Example
//
//  Created by Аслан Кутумбаев on 30.05.2023.
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

import UIKit

protocol WMNewMessgaeViewDelegate: AnyObject {
    func sendMessage(_ message: String)
}

class WMNewMessageView: UIView {
    @IBOutlet var inputTextView: UITextView!
    @IBOutlet var sendMessageButton: UIButton!
    
    weak var delegate: WMNewMessgaeViewDelegate?
    
    private let maxHeight: CGFloat = WMNewMessageConstants.maxHeight
    
    private var isOversized: Bool  = false {
        didSet {
            guard oldValue != isOversized else { return }
            
            layoutIfNeeded()
            inputTextView.isScrollEnabled = isOversized
            inputTextView.setNeedsUpdateConstraints()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let textSize = inputTextView.sizeThatFits(
            CGSize(
                width: inputTextView.bounds.width,
                height: CGFloat.greatestFiniteMagnitude
            )
        )
        return CGSize(width: self.bounds.width, height: textSize.height)
    }
    
    func initialSetup() {
        autoresizingMask = UIView.AutoresizingMask.flexibleHeight
        inputTextView.delegate = self
        inputTextView.isScrollEnabled = false
        sendMessageButton.accessibilityIdentifier = "sendMessageButton"
        inputTextView.accessibilityIdentifier = "inputTextView"
    }
    
    @IBAction func sendMessage(_ sender: Any?) {
        delegate?.sendMessage(inputTextView.text)
    }
}

extension WMNewMessageView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        isOversized = textView.contentSize.height >= maxHeight
    }
}
