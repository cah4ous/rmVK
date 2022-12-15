// NewsImageCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Изображение поста ячейки
final class NewsImageCell: UITableViewCell, NewsCellConfigurable {
    // MARK: - Private IBOutlets

    @IBOutlet private var postImageView: UIImageView!

    var photoCacheService = PhotoCacheService()

    // MARK: - Public Methods

    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }

    func configure(_ news: NewsFeed, photoCacheService: PhotoCacheService) {
        postImageView.image = photoCacheService.photo(byUrl: news.attachments?.first?.photo?.urls.last?.url ?? "")
    }
}
