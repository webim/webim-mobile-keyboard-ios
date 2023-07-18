//
//  ChatViewController.swift
//  WebimKeyboard_Example
//
//  Created by Аслан Кутумбаев on 24.05.2023.
//  Copyright © 2023 Webim.ru All rights reserved.
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
import WebimKeyboard

class ChatViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.keyboardDismissMode = .interactiveWithAccessory
        tableView.accessibilityIdentifier = "tableView"
        return tableView
    }()
    
    let toolbarView: WMNewMessageView = {
        let view = Bundle.main.loadNibNamed("WMNewMessageView", owner: ChatViewController.self)?.first as! WMNewMessageView
        view.initialSetup()
        return view
    }()
    
    let keyboardManager = WMKeyboardManager()
    
    override var inputAccessoryView: UIView? {
        return toolbarView
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardManager.delegate = self
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        toolbarView.delegate = self
        
        setupViewHierarchy()
        setupTableViewConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeOnKeyboardNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupTableView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func setupViewHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupTableView() {
        tableView.reloadData()
        tableView.setContentOffset(CGPoint(x: .zero, y: tableView.contentSize.height), animated: false)
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "tableViewCell")
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }
}

extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        toolbarView.inputTextView?.resignFirstResponder()
    }
}

extension ChatViewController: WMKeyboardObservable, WMKeyboardRepresentable {
    func keyboardWillShow(keyboardInfo: Notification.KeyboardInfo) {
        keyboardManager.adjustKeyboardNotification(keyboardInfo, kind: .keyboardWillShow)
    }
    
    func keyboardWillHide(keyboardInfo: Notification.KeyboardInfo) {
        keyboardManager.adjustKeyboardNotification(keyboardInfo, kind: .keyboardWillHide)
    }
    
    func keyboardDidShow(keyboardInfo: Notification.KeyboardInfo) {
        keyboardManager.adjustKeyboardNotification(keyboardInfo, kind: .keyboardDidShow)
    }
    
    func keyboardDidHide(keyboardInfo: Notification.KeyboardInfo) {
        keyboardManager.adjustKeyboardNotification(keyboardInfo, kind: .keyboardDidHide)
    }
}

extension ChatViewController: WMKeyboardManagerDelegate {
    var scrollViewModel: WebimKeyboard.WMScrollViewModel {
        WMScrollViewModel(
            toolbarViewHeight: inputAccessoryView?.frame.height ?? 0,
            scrollViewContentOffset: tableView.contentOffset.y,
            scrollViewContentInset: tableView.contentInset.bottom
        )
    }
    
    var presented: Bool {
        return presentedViewController != nil
    }
    
    func set(contentOffset: CGFloat) {
        tableView.setContentOffset(CGPoint(x: .zero, y: contentOffset), animated: false)
    }
    
    func set(contentInset: CGFloat) {
        tableView.contentInset.bottom = contentInset
        tableView.scrollIndicatorInsets.bottom = contentInset
    }
    
    func layoutIfNeeded() {
        view.layoutIfNeeded()
    }
}

extension ChatViewController: WMNewMessgaeViewDelegate {
    
    func sendMessage(_ message: String) {
        guard let action = Action(rawValue: message) else { return }
        switch action {
        case .showAlert:
            showAlert()
        case .pushVC:
            pushVC()
        case .pushChat:
            pushChat()
        case .presentVC:
            presentVC()
        }
    }
    
    private enum Action: String {
        case showAlert
        case pushVC
        case pushChat
        case presentVC
    }
    
    private func pushVC() {
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func pushChat() {
        let vc = ChatViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showAlert() {
        let alert = UIAlertController(
            title: "Alert",
            message: "message",
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(action)
        
        action.accessibilityIdentifier = "Ok"
        
        present(alert, animated: true)
    }
    
    private func presentVC() {
        let vc = UIViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.view.backgroundColor = .red
        present(vc, animated: false) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                vc.dismiss(animated: false)
            }
        }
    }
}
