//
//  CustomCell.swift
//  Movies
//
//  Created by Aleksandra on 14.11.2022.
//

import UIKit
import Kingfisher

final class CustomCell: UITableViewCell {
    // MARK: - Identifier
    static let identifier = "cell"
    
    // MARK: - Subviews
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return  image
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .heavy)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 16
        return label
    }()
    
    private lazy var movieDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private lazy var star: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "star")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var rating: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .heavy)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        stack.addArrangedSubview(star)
        stack.addArrangedSubview(rating)
        return stack
    }()
    
    //MARK: - Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
        title.text = nil
        movieDescription.text = nil
    }
    
    // MARK: - Internal setup
    func setMovieCell(movie: Movie, description: String?) {
        if let urlImage = URL(string: movie.image) {
            let source = ImageResource(downloadURL: urlImage, cacheKey: movie.image)
            image.kf.setImage(with: source)
        }
        title.text = movie.title
        movieDescription.text = description
        rating.text = "\(movie.rating) / 10"
    }
    
    // MARK: - Private configure
    private func configure() {
        addSubview(image)
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            image.widthAnchor.constraint(equalToConstant: 110)
        ])
        
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            stack.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor,constant: 15),
            title.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 5),
            title.trailingAnchor.constraint(equalTo: stack.leadingAnchor, constant: -10),
            title.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        addSubview(movieDescription)
        NSLayoutConstraint.activate([
            movieDescription.topAnchor.constraint(equalTo: title.bottomAnchor,constant: 5),
            movieDescription.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 5),
            movieDescription.trailingAnchor.constraint(equalTo: stack.leadingAnchor, constant: -10),
            movieDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
}
