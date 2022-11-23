//
//  Response.swift
//  vkHW
//
//  Created by Александр Троицкий on 23.11.2022.
//

import Foundation

/// Полученный ответ от ВК
struct VKAPIResponse: Codable {
    let response: VKResponse
}

/// ВК респонс
struct VKResponse: Codable {
    let count: Int
    let items: [VKFriend]
}
