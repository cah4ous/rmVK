// NewsHeaderCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Автор публикации
final class NewsHeaderCell: UITableViewCell, NewsCellConfigurable {
    // MARK: - Private IBOutlets

    @IBOutlet private var postAvatarImageView: UIImageView!
    @IBOutlet private var postAvatarNameLabel: UILabel!
    @IBOutlet private var postDateLabel: UILabel!

    // MARK: - Public Methods

    func configure(_ news: NewsFeed, networkService: NetworkService) {
        guard let data = networkService.downloadImage(url: news.avatarPath ?? "") else { return }

        postAvatarNameLabel.text = news.authorName
        postAvatarImageView.image = UIImage(data: data)
        postDateLabel.text = dateFormatter(date: news.date)
    }

    // MARK: - Private Methods

    private func dateFormatter(date: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(date))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
}
