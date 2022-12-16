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

    // MARK: - Public Methods

    func configure(_ news: NewsFeed, networkService: NetworkService) {
        guard let url = news.avatarPath else { return }
        postAvatarNameLabel.text = news.authorName
        postAvatarImageView.image = photoCacheService.photo(byUrl: url)
        postDateLabel.text = convert(date: news.date)
    }

    func convert(date: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(date))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormat
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
}
