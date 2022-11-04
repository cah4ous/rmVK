// AvatarView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Кастомизация аватарки пользователя
class AvatarView: UIView {
    // MARK: - IBInspectable Properties

    @IBInspectable var shadowColor: UIColor = .darkGray {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }

    @IBInspectable var shadowOpacity: Float = 1 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }

    @IBInspectable var shadowRadius: CGFloat = 2 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }

    // MARK: - Public Properties

    var image: UIImage? {
        didSet {
            avatarImageView.image = image
        }
    }

    // MARK: - Private Properties

    private var avatarImageView = UIImageView()

    // MARK: - Initializers

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        initMethods()
    }

    private func initMethods() {
        settingsLayer()
        createAvatarImageView()
    }

    private func createAvatarImageView() {
        avatarImageView.frame = bounds
        avatarImageView.layer.cornerRadius = bounds.width / 2
        avatarImageView.clipsToBounds = true

        addSubview(avatarImageView)
    }

    private func settingsLayer() {
        layer.cornerRadius = bounds.width / 2
        layer.shadowColor = shadowColor.cgColor
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = CGSize(width: 5, height: 5)
    }
}
