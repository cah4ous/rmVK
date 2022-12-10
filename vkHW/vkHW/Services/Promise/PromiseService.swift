// PromiseService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import PromiseKit

/// Сетевые запросы через PromiseKit
final class PromiseService {
    // MARK: - Public Method

    func sendFriendsRequest() -> Promise<ResponseUsers> {
        let promise = Promise<ResponseUsers> { resolver in
            AF.request(NetworkRequests.friends.urlPath)
                .responseData { response in
                    guard let response = response.data else { return }
                    do {
                        let object = try JSONDecoder().decode(ResponseUsers.self, from: response)
                        resolver.fulfill(object)
                    } catch {
                        resolver.reject(error)
                    }
                }
        }
        return promise
    }
}
