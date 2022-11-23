// AutorisationViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
import WebKit

/// Экран авторизации
final class AutorisationViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let accessToken = "access_token"
        static let userId = "user_id"
        static let schemaValue = "https"
        static let hostValue = "oauth.vk.com"
        static let pathValue = "/authorize"
        static let blankPathValue = "/blank.html"
        static let clientIdFieldName = "client_id"
        static let clientIdValue = "51468498"
        static let displayFieldName = "display"
        static let displayValue = "mobile"
        static let redirectUrlFieldName = "redirect_url"
        static let redirectUrlValue = "https://oauth.vk.com/blank.html"
        static let scopeFieldName = "scope"
        static let scopeValue = "262150"
        static let respondeTypeFieldName = "response_type"
        static let respondeTypeValue = "token"
        static let versionFieldName = "v"
        static let versionValue = "5.68"
        static let equalSign = "="
        static let appersandSign = "&"
    }

    // MARK: - IBOutlets

    @IBOutlet var wkWebView: WKWebView! {
        didSet {
            wkWebView.navigationDelegate = self
        }
    }

    // MARK: - Private Properties

    private var session = Session.shared
    private var apiService = VKAPIService()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initMethods()
    }

    // MARK: - Private methods

    private func initMethods() {
        loadAuthPage()
        loadInfo()
    }

    private func loadInfo() {
        apiService.loadMyPhotos()
        apiService.loadMyGroups()
        apiService.loadMyFriends()
    }

    private func loadAuthPage() {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.schemaValue
        urlComponents.host = Constants.hostValue
        urlComponents.path = Constants.pathValue
        urlComponents.queryItems = [
            URLQueryItem(name: Constants.clientIdFieldName, value: Constants.clientIdValue),
            URLQueryItem(name: Constants.displayFieldName, value: Constants.displayValue),
            URLQueryItem(name: Constants.redirectUrlFieldName, value: Constants.redirectUrlValue),
            URLQueryItem(name: Constants.scopeFieldName, value: Constants.scopeValue),
            URLQueryItem(name: Constants.respondeTypeFieldName, value: Constants.respondeTypeValue),
            URLQueryItem(name: Constants.versionFieldName, value: Constants.versionValue)
        ]
        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)

        wkWebView.load(request)
    }
}

// WKNavigationDelegate
extension AutorisationViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationResponse:
        WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
    ) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
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
              let userId = params[Constants.userId]
        else {
            decisionHandler(.allow)
            return
        }

        Session.shared.token = token
        Session.shared.userId = userId

        wkWebView.removeFromSuperview()
        decisionHandler(.cancel)
    }
}
