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

    @IBOutlet private var wkWebView: WKWebView! {
        didSet {
            wkWebView.navigationDelegate = self
        }
    }

    // MARK: - Private Properties

    private var session = Session.shared
    private var vkAPIService = VKAPIService()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initMethods()
    }

    // MARK: - Private methods

    private func initMethods() {
        loadInfo()
    }

    private func loadPage() {
        guard let url = vkAPIService.loadAuthPage() else { return }
        let request = URLRequest(url: url)

        wkWebView.load(request)
    }

    private func loadInfo() {
        loadPage()
        vkAPIService.fetchMyPhotos()
//        vkAPIService.fetchMyGroups()
//        vkAPIService.loadMyFriends()
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
              let userID = params[Constants.userID]
        else {
            decisionHandler(.allow)
            return
        }

        Session.shared.token = token
        Session.shared.userID = userID

        wkWebView.removeFromSuperview()
        decisionHandler(.cancel)
    }
}
