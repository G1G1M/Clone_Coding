import UIKit

class HomeViewController: UIViewController {
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "main"))
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.90
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
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
        
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 380)
        
        let logoImageView = UIImageView(image: UIImage(named: "netflix_logo"))
        logoImageView.frame = CGRect(x: 16, y: 30, width: 53, height: 57)
        headerView.addSubview(logoImageView)
        
        let tvShowsButton = UIButton()
        let moviesButton = UIButton()
        let myListButton = UIButton()
        [tvShowsButton, moviesButton, myListButton].forEach {
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.2)
        }
        tvShowsButton.setTitle("TV Shows", for: .normal)
        moviesButton.setTitle("Movies", for: .normal)
        myListButton.setTitle("My List", for: .normal)
        
        let menuStackView = UIStackView(arrangedSubviews: [tvShowsButton, moviesButton, myListButton])
        menuStackView.axis = .horizontal
        menuStackView.spacing = 39.4
        menuStackView.distribution = .equalSpacing
        menuStackView.frame = CGRect(x: logoImageView.frame.maxX + 23, y: 30, width: 275, height: 57)
        headerView.addSubview(menuStackView)
        
        let myListStack = makeIconStack(imageName: "plus", title: "My List")
        let playButton = makePlayButton()
        let infoStack = makeIconStack(imageName: "info.circle", title: "Info")
        let bottomStackView = UIStackView(arrangedSubviews: [myListStack, playButton, infoStack])
        bottomStackView.axis = .horizontal
        bottomStackView.spacing = 20
        bottomStackView.distribution = .equalSpacing
        bottomStackView.frame = CGRect(x: 54, y: 320, width: view.frame.width - 116, height: 45)
        headerView.addSubview(bottomStackView)
        
        tableView.tableHeaderView = headerView
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
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: mockDatas[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = sectionTitles[section]
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.backgroundColor = .clear
        label.frame = CGRect(x: 16, y: 0, width: tableView.frame.width - 34, height: 12)
        return label
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
