// NewsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Экран новостей
final class NewsTableViewController: UITableViewController {
    // MARK: Constants

    private enum Constants {
        static let newsHeaderCellIdentifier = "NewsHeaderCell"
        static let newsFooterCellIdentifier = "NewsFooterCell"
        static let newsPostCellIdentifier = "NewsPostCell"
        static let newsImageCellIdentifier = "NewsImageCell"
    }

    private enum NewsCellTypes: Int, CaseIterable {
        case header
        case content
        case footer
    }

    // MARK: Private Properties

    private var posts: [Posts] = []
    private var news: [NewsFeed] = []

    // MARK: - Public Properties

    private var networkService = NetworkService()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initMethods()
    }

    // MARK: - Public Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var item = news[indexPath.section]
        var identifier = ""

        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.newsHeaderCellIdentifier,
                for: indexPath
            ) as? NewsHeaderCell else { return UITableViewCell() }
            cell.configure(item)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.newsPostCellIdentifier,
                for: indexPath
            ) as? NewsPostCell else { return UITableViewCell() }
            cell.configure(item)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.newsFooterCellIdentifier,
                for: indexPath
            ) as? NewsFooterCell else { return UITableViewCell() }
            cell.configure(item)
            return cell
        default:
            break
        }
        return UITableViewCell()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        news.count
    }

    // MARK: - Private Methods

    private func initMethods() {
        createTableViewSettings()
        fetchPosts()
    }

    private func createTableViewSettings() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func filteringNews(response: Posts) {
        response.news.forEach { news in
            if news.sourceId < 0 {
                guard let group = response.groups.filter({ group in
                    group.id == news.sourceId * -1
                }).first else { return }
                news.authorName = group.name
                news.avatarPath = group.photoImageName
            } else {
                guard let user = response.friends.filter({ user in
                    user.id == news.sourceId
                }).first else { return }
                news.authorName = "\(user.firstName) \(user.lastName)"
                news.avatarPath = user.photoImageName
            }
        }
        news = response.news
        tableView.reloadData()
    }

    private func fetchPosts() {
        networkService.fetchUserPosts { [weak self] item in
            guard let self = self else { return }
            switch item {
            case let .success(data):
                self.filteringNews(response: data.posts)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
