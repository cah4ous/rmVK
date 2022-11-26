// AutorisationViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
import WebKit

/// Экран авторизации
final class AutorisationViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let accessToken = "access_token"
        static let userID = "user_id"
        static let segueIdentifier = "menuVC"
        static let urlPath = "/blank.html"
    }

    // MARK: - IBOutlets

    @IBOutlet private var wkWebView: WKWebView! {
        didSet {
            wkWebView.navigationDelegate = self
        }
    }

    // MARK: - Private Properties

    private var session = Session.shared
    private var vkAPIService = VKAPIService()

    private var users: [User] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initMethods()
    }

    // MARK: - Private Methods

    private func showAuthorizationWebView() {
        guard let authorizationURL = URL(string: NetworkRequests.authorization.urlPath) else { return }
        let request = URLRequest(url: authorizationURL)
        wkWebView.load(request)
    }

    private func initMethods() {
        showAuthorizationWebView()
    }
}

// MARK: - WKNavigationDelegate

extension AutorisationViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationResponse:
        WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
    ) {
        guard let url = navigationResponse.response.url, url.path == Constants.urlPath,
              let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }

        guard let token = params[Constants.accessToken],
              let userID = params[Constants.userID]
        else {
            decisionHandler(.allow)
            return
        }

        Session.shared.token = token
        Session.shared.userID = userID

        performSegue(withIdentifier: Constants.segueIdentifier, sender: nil)

        decisionHandler(.cancel)
    }
}
