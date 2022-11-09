// NewsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка новостей
final class NewsTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var avatarNameLabel: UILabel!
    @IBOutlet private var postTextLabel: UILabel!
    @IBOutlet private var postImageView: UIImageView!

    // MARK: Public Methods

    func configure(post: Post) {
        avatarImageView.image = UIImage(named: post.personImageName)
        avatarNameLabel.text = post.personName
        postTextLabel.text = post.postText
        postImageView.image = UIImage(named: post.postImageName)
    }
}
