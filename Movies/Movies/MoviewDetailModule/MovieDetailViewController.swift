//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Aleksandra on 17.11.2022.
//

import UIKit
import Kingfisher

final class MovieDetailViewController: UIViewController {
    // MARK: - private properties
    private let movie: MovieDetail
    
    // MARK: - Subviews
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var movieTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 23, weight: .heavy)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var movieDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private lazy var star: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "star")
        view.backgroundColor = .link
        view.tintColor = .white
        view.contentMode = .scaleAspectFit
        view.frame = CGRect(x: 0, y: 0, width: 30, height: 15)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var rating: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .heavy)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var trailerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(showTrailer), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life cycle
    init(movie: MovieDetail) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - @objc Actions
    @objc
    private func showTrailer() {
        guard let url = URL(string: movie.trailer)
        else {
            presentAlertOnMainThread(title: "Oops, something went wrong!",
                                     message: "Check your internet connection and try again.",
                                     buttonTitle: "Okay")
            return
        }
        presentSafariVC(with: url)
    }
}

// MARK: - Private extension
private extension MovieDetailViewController {
    func setupUI() {
        view.backgroundColor = .systemGray6
        title = "Movie Detail"
        navigationController?.navigationBar.prefersLargeTitles = false
        configureImage()
        configureTitle()
        configureRating()
        configureDescription()
        configureTrailer()
        fillUpUI(movie: movie)
    }
    
    func fillUpUI(movie: MovieDetail) {
        if let urlImage = URL(string: movie.image) {
            let source = ImageResource(downloadURL: urlImage, cacheKey: movie.image)
            image.kf.setImage(with: source)
        }
        movieTitle.text = movie.title
        rating.text = "\(movie.rating) / 10"
        movieDescription.text = movie.welcomeDescription
        trailerButton.setTitle(movie.trailer, for: .normal)
        
    }
    
    func configureImage() {
        view.addSubview(image)
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            image.heightAnchor.constraint(equalToConstant: 300),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTitle() {
        view.addSubview(movieTitle)
        NSLayoutConstraint.activate([
            movieTitle.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            movieTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            movieTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
    }
    
    func configureRating() {
        view.addSubview(rating)
        NSLayoutConstraint.activate([
            rating.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 10),
            rating.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            rating.heightAnchor.constraint(equalToConstant: 15)
        ])
        
        view.addSubview(star)
        NSLayoutConstraint.activate([
            star.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 5),
            star.leadingAnchor.constraint(equalTo: rating.trailingAnchor, constant: 3),
            star.heightAnchor.constraint(equalToConstant: 25),
            star.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureDescription() {
        view.addSubview(movieDescription)
        NSLayoutConstraint.activate([
            movieDescription.topAnchor.constraint(equalTo: star.bottomAnchor, constant: 5),
            movieDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            movieDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
            
        ])
    }
    
    func configureTrailer() {
        view.addSubview(trailerButton)
        NSLayoutConstraint.activate([
            trailerButton.topAnchor.constraint(equalTo: movieDescription.bottomAnchor, constant: 25),
            trailerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            trailerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
    }
}
