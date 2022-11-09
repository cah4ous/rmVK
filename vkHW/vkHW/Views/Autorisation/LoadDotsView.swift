// LoadDotsView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Анимированные точки
final class LoadDotsView: UIView {
    // MARK: Private Visual Components

    private var dotsStackView: UIStackView?
    private lazy var pointViews: [UIView] = []

    // MARK: - Lifecycle

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Public Methods

    override func layoutSubviews() {
        dotsStackView?.frame = bounds
    }

    // MARK: - Private Methods

    private func setupView() {
        createDotaStackView()
    }

    private func createDotaStackView() {
        for _ in 0 ..< 3 {
            let view = UIView()
            view.backgroundColor = .systemBlue
            view.heightAnchor.constraint(equalToConstant: bounds.height - 5).isActive = true
            view.layer.cornerRadius = (bounds.height - 5) / 2
            view.alpha = 0.5
            view.layer.masksToBounds = true
            pointViews.append(view)
        }
        dotsStackView = UIStackView(arrangedSubviews: pointViews)

        guard let dotsStackView = dotsStackView else { return }

        dotsStackView.spacing = 8
        dotsStackView.axis = .horizontal
        dotsStackView.alignment = .center
        dotsStackView.distribution = .fillEqually
        addSubview(dotsStackView)
        animateDots()
    }

    private func animateDots() {
        var delay = 0.0
        pointViews.forEach { point in
            delay += 0.3
            makeOpacity(for: point, delay: delay)
        }
    }

    private func makeOpacity(for view: UIView, delay: Double) {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1
        animation.toValue = 0.5
        animation.duration = 0.7
        animation.beginTime = CACurrentMediaTime() + delay
        animation.repeatCount = .infinity
        animation.fillMode = .backwards
        animation.autoreverses = true
        view.layer.add(animation, forKey: nil)
    }
}
