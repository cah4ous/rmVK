// FriendPhotoViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import UIKit

/// Экран изображений
final class FriendPhotoViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
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

    var id = ""
    var navController: UINavigationController?

    // MARK: - Private Properties

    private var networkService = NetworkService()
    private var realmService = RealmService()
    private var photos: [Photo] = []
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
        loadImagesToRealm()
        createSwipeGestureRecognizer()
        createSettingsFriendImageView()
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
        guard index < photos.count, index >= 0 else {
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
            }, completion: { [self] _ in
                self.friendImageView.layer.opacity = 1
                self.friendImageView.transform = .identity

                self.friendImageView.loadData(
                    url: self.photos[self.index].urls.last?.url ?? "",
                    networkService: networkService
                )
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

    private func setupFirstImageView() {
        if !photos.isEmpty {
            friendImageView.loadData(url: photos[index].urls.last?.url ?? "", networkService: networkService)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

    private func loadImagesToRealm() {
        do {
            let realm = try Realm()
            let newPhotos = Array(realm.objects(Photo.self).where { $0.ownerId == Int(id) ?? 0 })
            if photos != newPhotos {
                photos = newPhotos
                setupFirstImageView()
            } else {
                loadData()
            }

        } catch {
            print(error.localizedDescription)
        }
    }

    private func loadData() {
        networkService.fetchUserPhotos(userID: id) { [weak self] item in
            guard let self = self else { return }
            switch item {
            case let .success(data):
                self.photos = data.photos.photos
                self.realmService.saveDataToRealm(self.photos)
                self.setupFirstImageView()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
