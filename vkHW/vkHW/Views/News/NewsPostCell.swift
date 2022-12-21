// NewsPostCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Текст поста ячейки
final class NewsPostCell: UITableViewCell, NewsCellConfigurable {
    // MARK: - Private IBOutlets

    @IBOutlet private var postTextLabel: UILabel!

    // MARK: - Public Methods

    func configure(_ news: NewsFeed, photoCacheService: PhotoCacheService) {
        postTextLabel.text = news.text
    }
}
