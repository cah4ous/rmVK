// NewsPostCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Текст поста ячейки
final class NewsPostCell: UITableViewCell, NewsCellConfigurable {
    // MARK: - Private IBOutlets

    @IBOutlet private var postTextView: UITextView!

    // MARK: - Public Methods

    func configure(_ news: NewsFeed, networkService: NetworkService) {
        postTextView.text = news.text
    }
}
