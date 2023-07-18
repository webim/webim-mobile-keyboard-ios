//
//  WMKeyboardNotificationsObserverContainer.swift
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

/// Pool of observers. Implemented as singltone for retain reference on observers.
final class WMKeyboardNotificationsObserverContainer {

    // MARK: - Properties
    static let shared = WMKeyboardNotificationsObserverContainer()

    // MARK: - Private Properties
    private(set) var observers: [WMKeyboardNotificationsObserver] = []

    // MARK: - Internal Methods
    /**
     Returns new observer for view or nil if observer already exist.
        - Parameter view: object, which will be observed.
     */
    func newObserver(for view: WMKeyboardObservable) -> WMKeyboardNotificationsObserver? {
        guard observers.first(where: { $0.isLinked(to: view) }) == nil else {
            WMKeyboardLogger.shared.log("Generate new observer failed. Observer for \(view) already exist", level: .debug)
            return nil
        }
        let observer = WMKeyboardNotificationsObserver(view: view)
        observers.append(observer)
        return observer
    }

    /// Removes invalid observers, which have no view
    func removeInvalid() {
        WMKeyboardLogger.shared.log("Removing invalid observers", level: .debug)
        for observer in observers.filter({ $0.isInvalid }) {
            NotificationCenter.default.removeObserver(observer)
        }
        observers.removeAll(where: { $0.isInvalid })
    }

    /**
     Releases observer for given view
        - Parameter view: object, which will be observed.
     */
    func releaseObserver(for view: WMKeyboardObservable) {
        WMKeyboardLogger.shared.log("Removing observer for \(view)", level: .debug)
        for observer in observers.filter({ $0.isLinked(to: view) }) {
            NotificationCenter.default.removeObserver(observer)
        }
        observers.removeAll(where: { $0.isLinked(to: view) })
    }

}
