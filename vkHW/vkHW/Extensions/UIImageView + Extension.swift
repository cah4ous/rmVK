// UIImageView + Extension.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Загрузка и кеширование картинок
extension UIImageView {
    func load(url: String, networkService: NetworkService) {
        guard let data = networkService.downloadImage(url: url),
              let image = UIImage(data: data)
        else { return }
        self.image = image
    }
}
