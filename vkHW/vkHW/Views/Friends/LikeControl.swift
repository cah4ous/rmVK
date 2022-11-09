// LikeControl.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Контрол количества лайков
final class LikeControl: UIControl {
    // MARK: - Constants

    private enum Constants {
        static let defaultBlackColor = "defaultTextColor"
        static let heartImageName = "heart"
        static let heartFillImageName = "heart.fill"
    }

    // MARK: - Private Visual Components

    private var heartImageView = UIImageView()
    private var likeCountLabel = UILabel()

    // MARK: - Public Properties

    var likeCount: Int = 0 {
        didSet {
            likeCountLabel.text = String(likeCount)
        }
    }

    var isLiked: Bool = true {
        didSet {
            likeCountLabel.text = String(likeCount)
            if isLiked {
                heartImageView.image = UIImage(systemName: Constants.heartImageName)

            } else {
                heartImageView.image = UIImage(systemName: Constants.heartFillImageName)
            }
        }
    }

    // MARK: - Initializers

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Private Methods

    @objc private func touchUpInsideAction() {
        isLiked ? (likeCount += 1) : (likeCount -= 1)
        setupLikeAnimation()
        isLiked = !isLiked
    }

    private func setupUI() {
        initMethods()

        backgroundColor = UIColor.clear
    }

    private func setupLikeAnimation() {
        UIView.transition(
            with: likeCountLabel,
            duration: 1.0,
            options: .transitionFlipFromBottom,
            animations: nil
        )
    }

    private func initMethods() {
        createHeartSettings()
        createlikeCountLabelSettings()
        addTargets()
        createConstraints()
    }

    private func addTargets() {
        addTarget(self, action: #selector(touchUpInsideAction), for: .touchUpInside)
    }

    private func createConstraints() {
        heartConstraints()
        likeCountLabelConstraints()
    }

    private func createHeartSettings() {
        heartImageView.image = UIImage(systemName: Constants.heartImageName)
        heartImageView.contentMode = .scaleAspectFit

        addSubview(heartImageView)
    }

    private func heartConstraints() {
        heartImageView.translatesAutoresizingMaskIntoConstraints = false

        heartImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        heartImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 1).isActive = true
        heartImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        heartImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }

    private func createlikeCountLabelSettings() {
        likeCountLabel.text = String(likeCount)
        likeCountLabel.textAlignment = .center
        likeCountLabel.textColor = UIColor(named: Constants.defaultBlackColor)

        addSubview(likeCountLabel)
    }

    private func likeCountLabelConstraints() {
        likeCountLabel.translatesAutoresizingMaskIntoConstraints = false

        likeCountLabel.leadingAnchor.constraint(equalTo: heartImageView.trailingAnchor, constant: 5).isActive = true
        likeCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        likeCountLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
