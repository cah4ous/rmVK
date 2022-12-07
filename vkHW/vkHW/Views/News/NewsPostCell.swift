// NewsPostCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Текст поста ячейки
final class NewsPostCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var postTextView: UITextView!

    // MARK: - Public Methods

    func configure(_ news: NewsFeed) {
        postTextView.text = news.text
    }
}
