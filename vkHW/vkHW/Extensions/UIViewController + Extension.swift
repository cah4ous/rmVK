// UIViewController + Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Алерт ошибки пустых данных
extension UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let alertActionText = "Окей"
    }

    // MARK: - Public Methods

    func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.alertActionText, style: .default))
        present(alert, animated: true, completion: nil)
    }
}
