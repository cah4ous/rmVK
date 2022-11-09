// NewsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Экран новостей
final class NewsTableViewController: UITableViewController {
    // MARK: Constants

    private enum Constants {
        static let cellIdentifier = "NewsTableViewCell"
        static let imageNameText = "0"
        static let postText = "suiiii"
        static let personalNameText = "oleg"
    }

    // MARK: Private Properties

    private var posts = [
        Post(
            personImageName: Constants.imageNameText,
            personName: Constants.personalNameText,
            postText: Constants.postText,
            postImageName: Constants.imageNameText
        ),
        Post(
            personImageName: Constants.imageNameText,
            personName: Constants.personalNameText,
            postText: Constants.postText,
            postImageName: Constants.imageNameText
        ),
        Post(
            personImageName: Constants.imageNameText,
            personName: Constants.personalNameText,
            postText: Constants.postText,
            postImageName: Constants.imageNameText
        ),
        Post(
            personImageName: Constants.imageNameText,
            personName: Constants.personalNameText,
            postText: Constants.postText,
            postImageName: Constants.imageNameText
        )
    ]

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initMethods()
    }

    // MARK: - Public Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let newsCell = tableView.dequeueReusableCell(
            withIdentifier: Constants.cellIdentifier, for: indexPath
        )
            as? NewsTableViewCell else { return UITableViewCell() }
        newsCell.configure(post: posts[indexPath.row])
        return newsCell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    // MARK: - Private Methods

    private func initMethods() {
        createTableViewSettings()
    }

    private func createTableViewSettings() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(
            nibName: Constants.cellIdentifier,
            bundle: nil
        ), forCellReuseIdentifier: Constants.cellIdentifier)

        tableView.rowHeight = UITableView.automaticDimension
    }
}
