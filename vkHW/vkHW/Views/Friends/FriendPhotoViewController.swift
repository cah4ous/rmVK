// FriendPhotoViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран изображений
final class FriendPhotoViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let firstPhotoImageName = "0"
        static let secondPhotoImageName = "vkImage"
        static let translationX = 500
        static let negativeTranslationX = -500
        static let defaultScaleX = 0.6
        static let defaultDuration = 0.7
        static let swipeDownDefaultScaleX = 0.3
        static let defaultTranslationY = 1500.0
        static let defaultOpacity: Float = 0.2
    }

    // MARK: - IBOutlets

    @IBOutlet private var friendImageView: UIImageView!

    // MARK: - Public Properties

    var images = [
        UIImage(named: Constants.firstPhotoImageName),
        UIImage(named: Constants.secondPhotoImageName),
        UIImage(named: Constants.firstPhotoImageName),
        UIImage(named: Constants.secondPhotoImageName)
    ]

    var navController: UINavigationController?

    // MARK: - Private Properties

    private var index = Int()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initMethods()
    }

    // MARK: Private Methods

    @objc private func respondToSwipeGestureAction(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                swipe(translationX: Constants.negativeTranslationX, increaseIndex: 1)
            case UISwipeGestureRecognizer.Direction.right:
                swipe(translationX: Constants.translationX, increaseIndex: -1)
            case UISwipeGestureRecognizer.Direction.down:
                swipeDown()
            default: break
            }
        }
    }

    private func initMethods() {
        createSwipeGestureRecognizer()
    }

    private func createSettingsFriendImageView() {
        friendImageView.isUserInteractionEnabled = true
    }

    private func createSwipeGestureRecognizer() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGestureAction))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        friendImageView.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGestureAction))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        friendImageView.addGestureRecognizer(swipeLeft)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGestureAction))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        friendImageView.addGestureRecognizer(swipeDown)
    }

    private func swipe(translationX: Int, increaseIndex: Int) {
        index += increaseIndex
        guard index < images.count, index >= 0 else {
            index -= increaseIndex
            return
        }
        UIView.animate(
            withDuration: 1,
            animations: {
                let translation = CGAffineTransform(translationX: CGFloat(translationX), y: 0)
                self.friendImageView.transform = translation
                    .concatenating(CGAffineTransform(scaleX: Constants.defaultScaleX, y: Constants.defaultScaleX))
                self.friendImageView.layer.opacity = Constants.defaultOpacity
            }, completion: { _ in
                self.friendImageView.layer.opacity = 1
                self.friendImageView.transform = .identity
                self.friendImageView.image = self.images[self.index]
            }
        )
    }

    private func swipeDown() {
        UIView.animate(
            withDuration: Constants.defaultDuration,
            animations: {
                let translation = CGAffineTransform(translationX: 0, y: Constants.defaultTranslationY)
                self.friendImageView.transform = translation
                    .concatenating(CGAffineTransform(
                        scaleX: Constants.swipeDownDefaultScaleX,
                        y: Constants.swipeDownDefaultScaleX
                    ))
            },
            completion: { _ in
                self.navController?.popViewController(animated: true)
            }
        )
    }
}
