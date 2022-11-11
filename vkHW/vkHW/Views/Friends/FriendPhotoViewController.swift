// FriendPhotoViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран изображений
final class FriendPhotoViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        static let firstPhotoImageName = "0"
        static let secondPhotoImageName = "vkImage"
    }
    // MARK: - IBOutlets

    @IBOutlet var friendImageView: UIImageView!

    // MARK: - Public Properties

    var photo = [UIImage(named: Constants.firstPhotoImageName), UIImage(named: Constants.secondPhotoImageName), UIImage(named: Constants.firstPhotoImageName), UIImage(named: Constants.secondPhotoImageName)]
    var navController: UINavigationController?

    // MARK: Private Properties

    private var index = Int()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        friendImageView.isUserInteractionEnabled = true
        createSwipeGestureRecognizer()
    }

    // MARK: Private Methods

    private func createSwipeGestureRecognizer() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        friendImageView.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        friendImageView.addGestureRecognizer(swipeLeft)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        friendImageView.addGestureRecognizer(swipeDown)
    }

    @objc private func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                swipe(translationX: -500, increaseIndex: 1)
            case UISwipeGestureRecognizer.Direction.right:
                swipe(translationX: 500, increaseIndex: -1)
            case UISwipeGestureRecognizer.Direction.down:
                swipeDown()
            default: break
            }
        }
    }

    private func swipe(translationX: Int, increaseIndex: Int) {
        index += increaseIndex
        guard index < photo.count, index >= 0 else {
            index -= increaseIndex
            return
        }
        UIView.animate(
            withDuration: 1,
            animations: {
                let translation = CGAffineTransform(translationX: CGFloat(translationX), y: 0)
                self.friendImageView.transform = translation.concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
                self.friendImageView.layer.opacity = 0.2
            }, completion: { _ in
                self.friendImageView.layer.opacity = 1
                self.friendImageView.transform = .identity
                self.friendImageView.image = self.photo[self.index]
            }
        )
    }

    private func swipeDown() {
        UIView.animate(
            withDuration: 0.7,
            animations: {
                let translation = CGAffineTransform(translationX: 0, y: 1500)
                self.friendImageView.transform = translation.concatenating(CGAffineTransform(scaleX: 0.3, y: 0.3))
            },
            completion: { _ in
                self.navController?.popViewController(animated: true)
            }
        )
    }
}
