// NewsHeaderCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Автор публикации
final class NewsHeaderCell: UITableViewCell, NewsCellConfigurable {
    // MARK: - Private IBOutlets

    @IBOutlet private var postAvatarImageView: UIImageView!
    @IBOutlet private var postAvatarNameLabel: UILabel!
    @IBOutlet private var postDateLabel: UILabel!

    // MARK: - Private Properties

    private let dateFormatter = DateFormatter()

    // MARK: - Public Methods

    func configure(_ news: NewsFeed, photoCacheService: PhotoCacheService) {
        guard let url = news.avatarPath else { return }
        postAvatarNameLabel.text = news.authorName
        postAvatarImageView.image = photoCacheService.photo(byUrl: url)
        postDateLabel.text = dateFormatter.convert(date: news.date)
    }
}
