// NewsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка новостей
final class NewsTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var avatarNameLabel: UILabel!
    @IBOutlet var postTextLabel: UILabel!
    @IBOutlet var postImageView: UIImageView!

    // MARK: Public Methods

    func configure(post: Post) {
        avatarImageView.image = UIImage(named: post.personImageName)
        avatarNameLabel.text = post.personName
        postTextLabel.text = post.postText
        postImageView.image = UIImage(named: post.postImageName)
    }
}
