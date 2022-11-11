// CustomPushAnimator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Анимации пуша
final class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: - Constants
    private enum Constants {
        static let translationX = -200.0
        static let relativeDuration = 0.5
        static let defaultScale = 0.8
    }
    // MARK: - Public Methods

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.7
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to) else { return }

        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = source.view.frame

        let translation = CGAffineTransform(
            translationX: source.view.frame.width / 2 + source.view.frame.height / 2,
            y: -source.view.frame.width / 2
        )

        let rotation = CGAffineTransform(rotationAngle: .pi / -2)

        destination.view.transform = rotation.concatenating(translation)
        destination.view.center = CGPoint(
            x: source.view.bounds.width + source.view.bounds.height / 2,
            y: source.view.bounds.width / 2
        )

        UIView.animateKeyframes(
            withDuration: transitionDuration(using: transitionContext),
            delay: 0,
            options: .calculationModePaced
        ) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: Constants.relativeDuration) {
                let translation = CGAffineTransform(translationX: Constants.translationX, y: 0)
                let scale = CGAffineTransform(scaleX: Constants.defaultScale, y: Constants.defaultScale)
                source.view.transform = translation.concatenating(scale)
            }

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: Constants.relativeDuration) {
                destination.view.transform = .identity
                destination.view.center = source.view.center
            }
        } completion: { finish in
            if finish, !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
            }
            transitionContext.completeTransition(finish && !transitionContext.transitionWasCancelled)
        }
    }
}
