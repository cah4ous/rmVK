// NewsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Экран новостей
final class NewsTableViewController: UITableViewController, UITableViewDataSourcePrefetching {
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
        case image
        case footer
    }

    // MARK: - Visual Components

    private let refreshControll = UIRefreshControl()

    // MARK: Private Properties

    private let networkService = NetworkService()
    private var posts: [Posts] = []
    private var news: [NewsFeed] = []
    private var photoCacheService = PhotoCacheService()
    private var nextPage = ""
    private var currentDate = 0
    private var isLoading = false

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.prefetchDataSource = self
        initMethods()
    }

    // MARK: - Public Methods

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let sections = indexPaths.map(\.section)
        guard let maxSection = sections.max(),
              maxSection > news.count - 3,
              isLoading == false
        else { return }
        isLoading = true
        networkService.fetchUserPosts(startTime: nil, nextPage: nextPage) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                let indexSet = (self.news.count ..< self.news.count + data.posts.newsFeeds.count).map { $0 }
                self.currentDate = data.posts.newsFeeds.first?.date ?? 0
                self.news.append(contentsOf: data.posts.newsFeeds)
                self.isLoading = false
                self.tableView.insertSections(IndexSet(indexSet), with: .automatic)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 2:
            let tableWidth = tableView.bounds.width
            guard let aspectRatio = news[indexPath.section].attachments?.last?.photo?.urls.first?.aspectRatio
            else { return CGFloat() }
            let cellHeight = tableWidth * aspectRatio
            return cellHeight
        default:
            return UITableView.automaticDimension
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NewsCellTypes.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var post = news[indexPath.section]
        let cellType = NewsCellTypes(rawValue: indexPath.row) ?? .image
        var cellIdentifier = ""

        switch cellType {
        case .header:
            cellIdentifier = Constants.newsHeaderCellIdentifier
        case .image:
            cellIdentifier = Constants.newsImageCellIdentifier
        case .footer:
            cellIdentifier = Constants.newsFooterCellIdentifier
        case .content:
            cellIdentifier = Constants.newsPostCellIdentifier
        }
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier,
            for: indexPath
        ) as? NewsCell else { return UITableViewCell() }
        cell.configure(post, photoCacheService: photoCacheService)
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        news.count
    }

    // MARK: - Private Methods

    @objc private func refreshDataAction() {
        fetchUserPosts()
        tableView.reloadData()
    }

    private func initMethods() {
        createTableViewSettings()
        fetchUserPosts()
        setupRefreshControll()
    }

    private func setupRefreshControll() {
        refreshControll.addTarget(
            self,
            action: #selector(refreshDataAction),
            for: .valueChanged
        )
    }

    private func createTableViewSettings() {
        tableView.addSubview(refreshControll)
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func filteringNews(response: Posts) {
        response.newsFeeds.forEach { news in
            if news.sourceId < 0 {
                guard let group = response.groups.filter({ group in
                    group.id == news.sourceId * -1
                }).first else { return }
                news.authorName = group.name
                news.avatarPath = group.photoImageName
            } else {
                guard let user = response.users.filter({ user in
                    user.id == news.sourceId
                }).first else { return }
                news.authorName = "\(user.firstName) \(user.lastName)"
                news.avatarPath = user.photoImageName
            }
        }
        news = response.newsFeeds
        tableView.reloadData()
    }

    private func fetchUserPosts() {
        var mostFreshDate: TimeInterval?
        if let firstItem = news.first {
            mostFreshDate = Double(firstItem.date) + 1
        }
        networkService.fetchUserPosts { [weak self] item in
            guard let self = self else { return }
            self.refreshControll.endRefreshing()
            switch item {
            case let .success(data):
                self.filteringNews(response: data.posts)
                self.nextPage = data.posts.nextPage ?? ""
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
