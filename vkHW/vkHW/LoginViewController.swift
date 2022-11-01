// LoginViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран авторизации
final class LoginViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let segueIdentifier = "menuVC"
        static let titleAlertText = "Заполните все данные"
        static let messageAlertText = "Вы должны заполнить пароль и логин"
        static let alertActionText = "Окей"
    }

    // MARK: - IBOutlets

    @IBOutlet private var loginTextField: UITextField!

    @IBOutlet private var passwordTextField: UITextField!

    @IBOutlet private var loginScrollView: UIScrollView!

    // MARK: - Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShown(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(hideKeyboard)
        )
        loginScrollView.addGestureRecognizer(tapGesture)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    // MARK: - IBActions

    @IBAction private func logInButtonAction(_ sender: Any) {
        if loginTextField.text?.isEmpty == false, passwordTextField.text?.isEmpty == false {
            performSegue(withIdentifier: Constants.segueIdentifier, sender: nil)
        } else {
            errorAlert(title: Constants.titleAlertText, message: Constants.messageAlertText)
        }
    }

    // MARK: - Private Methods

    @objc private func keyboardWillShown(notification: Notification) {
        guard let info = notification.userInfo as NSDictionary? else { return }
        guard let kbSize = (
            info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey)
                as? NSValue?
        )??.cgRectValue.size else { return }
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        loginScrollView.contentInset = contentInset
        loginScrollView.scrollIndicatorInsets = contentInset
    }

    @objc private func keyboardWillHide(notification: Notification) {
        loginScrollView.contentInset = UIEdgeInsets.zero
        loginScrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }

    @objc private func hideKeyboard() {
        loginScrollView.endEditing(true)
    }
}

/// Алерт ошибки пустых данных
extension LoginViewController {
    func errorAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.alertActionText, style: .default))
        present(alert, animated: true, completion: nil)
    }
}
