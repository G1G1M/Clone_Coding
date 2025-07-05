import UIKit

class HomeViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "main")
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.45
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "netflix_logo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let tvShowsButton = UIButton()
    let moviesButton = UIButton()
    let myListButton = UIButton()
    
    lazy var menuStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [tvShowsButton, moviesButton, myListButton])
        stack.axis = .horizontal
        stack.spacing = 39.4
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // 스택뷰로 만든 My List
    let myListStackView: UIStackView = {
        let icon = UIImageView(image: UIImage(systemName: "plus"))
        icon.tintColor = .white
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = "My List"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 13.64)
        label.textAlignment = .center
        
        let stack = UIStackView(arrangedSubviews: [icon, label])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 1
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // Play 버튼은 그대로 유지
    let playButton: UIButton = {
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
        return button
    }()
    
    // 스택뷰로 만든 Info
    let infoStackView: UIStackView = {
        let icon = UIImageView(image: UIImage(systemName: "info.circle"))
        icon.tintColor = .white
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = "Info"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 13.64)
        label.textAlignment = .center
        
        let stack = UIStackView(arrangedSubviews: [icon, label])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 1
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // 하단 버튼 스택뷰
    lazy var bottomButtonStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [myListStackView, playButton, infoStackView])
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setupUI() {
        // 상단 메뉴 버튼 텍스트
        tvShowsButton.setTitle("TV Shows", for: .normal)
        moviesButton.setTitle("Movies", for: .normal)
        myListButton.setTitle("My List", for: .normal)
        
        [tvShowsButton, moviesButton, myListButton].forEach {
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.2)
        }
        
        // 스크롤뷰 추가
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // 배경 이미지 추가
        contentView.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 324)
        ])
        
        // 상단 메뉴 추가
        contentView.addSubview(logoImageView)
        contentView.addSubview(menuStackView)
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 3),
            logoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logoImageView.widthAnchor.constraint(equalToConstant: 53),
            logoImageView.heightAnchor.constraint(equalToConstant: 57),
            
            menuStackView.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            menuStackView.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 23)
        ])
        
        // 하단 버튼 추가
        contentView.addSubview(bottomButtonStackView)
        NSLayoutConstraint.activate([
            bottomButtonStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 324),
            bottomButtonStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 54),
            bottomButtonStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -62),
            bottomButtonStackView.heightAnchor.constraint(equalToConstant: 45),
            
            playButton.widthAnchor.constraint(equalToConstant: 110),
            playButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}
