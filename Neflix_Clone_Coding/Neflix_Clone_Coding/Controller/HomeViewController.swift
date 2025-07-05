import UIKit

class HomeViewController: UIViewController {

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "main2"))
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.45
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
//        tableView.bounces = false
        return tableView
    }()

    private let sectionTitles = [
        "Trending Now",
        "Popular on Netflix",
        "Watch It Again",
        "New Releases",
        "Top Picks for You",
        "Award-Winning Films"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.backgroundColor = .black
    }

    private func setupViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9.0/11.0),

            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)

        // Header View
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        let headerContainer = UIView()
        headerContainer.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(headerContainer)

        NSLayoutConstraint.activate([
            headerContainer.topAnchor.constraint(equalTo: headerView.topAnchor),
            headerContainer.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            headerContainer.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            headerContainer.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])

        let logoImageView = UIImageView(image: UIImage(named: "netflix_logo"))
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.widthAnchor.constraint(equalToConstant: 53).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 57).isActive = true

        let tvShowsButton = createTopButton(title: "TV Shows")
        let moviesButton = createTopButton(title: "Movies")
        let myListButton = createTopButton(title: "My List")

        let menuStackView = UIStackView(arrangedSubviews: [tvShowsButton, moviesButton, myListButton])
        menuStackView.axis = .horizontal
        menuStackView.spacing = 33
        menuStackView.translatesAutoresizingMaskIntoConstraints = false

        let topStackView = UIStackView(arrangedSubviews: [logoImageView, menuStackView])
        topStackView.axis = .horizontal
        topStackView.alignment = .center
        topStackView.spacing = 20
        topStackView.translatesAutoresizingMaskIntoConstraints = false

        headerContainer.addSubview(topStackView)

        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: headerContainer.topAnchor, constant: 30),
            topStackView.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor, constant: 16),
            topStackView.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor, constant: -16)
        ])

        let myListStack = makeIconStack(imageName: "plus", title: "My List")
        let playButton = makePlayButton()
        let infoStack = makeIconStack(imageName: "info.circle", title: "Info")

        let bottomStackView = UIStackView(arrangedSubviews: [myListStack, playButton, infoStack])
        bottomStackView.axis = .horizontal
        bottomStackView.spacing = 20
        bottomStackView.distribution = .equalSpacing
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false

        headerContainer.addSubview(bottomStackView)

        NSLayoutConstraint.activate([
            bottomStackView.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor, constant: 64),
            bottomStackView.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor, constant: -44),
            bottomStackView.bottomAnchor.constraint(equalTo: headerContainer.bottomAnchor, constant: -15),
            bottomStackView.heightAnchor.constraint(equalToConstant: 45)
        ])

        headerView.heightAnchor.constraint(equalToConstant: 380).isActive = true
        tableView.tableHeaderView = headerView

        // Header View Sizing Trick
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 380)
    }

    private func createTopButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.2)
        return button
    }

    private func makeIconStack(imageName: String, title: String) -> UIStackView {
        let icon = UIImageView(image: UIImage(systemName: imageName))
        icon.tintColor = .white
        icon.contentMode = .scaleAspectFit

        let label = UILabel()
        label.text = title
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 13.64)
        label.textAlignment = .center

        let stack = UIStackView(arrangedSubviews: [icon, label])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 1
        return stack
    }

    private func makePlayButton() -> UIButton {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.title = "Play"
        config.image = UIImage(systemName: "play.fill")
        config.imagePadding = 15
        config.baseBackgroundColor = .lightGray
        config.baseForegroundColor = .black
        config.cornerStyle = .medium
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 110),
            button.heightAnchor.constraint(equalToConstant: 45)
        ])
        return button
    }
}

// MARK: - UITableViewDataSource & Delegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: mockDatas[indexPath.section])
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let container = UIView()
        let label = UILabel()
        label.text = sectionTitles[section]
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 6),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: container.topAnchor),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        return container
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 22
    }
}

// MARK: - Fade Effect
extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let fadeStart: CGFloat = 0
        let fadeEnd: CGFloat = 200
        let alpha = max(0, min(1, 1 - (offsetY - fadeStart) / (fadeEnd - fadeStart)))
        backgroundImageView.alpha = alpha * 0.8
    }
}
