//
//  ViewController.swift
//  Movies
//
//  Created by Aleksandra on 07.11.2022.
//

import UIKit

final class MovieListViewController: UIViewController {
    enum Section { case main }
    
    // MARK: - Private Properties
    private var movies: [Movie] = []
    private let presenter = MovieListPresenter()
    
    private var dataSource: UITableViewDiffableDataSource<Section, Movie>?
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        presenter.delegate = self
        configureTableView()
        presenter.getMovies()
    }
}

// MARK: - MovieListPresenterDelegate
extension MovieListViewController: MovieListPresenterDelegate {
    func updateMovieList(with movies: [Movie]) {
        self.movies = movies
        updateData(on: movies)
    }
    
    func updateMovieDetail(with movie: MovieDetail) {
        navigationController?.pushViewController(MovieDetailViewController(movie: movie),
                                                 animated: true)
    }
    
    func showError(with error: NameOfError) {
        presentAlertOnMainThread(title: "Oops...",
                                 message: error.rawValue,
                                 buttonTitle: "Okay")
    }
    
    func updateData(on movie: [Movie]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movie)
        DispatchQueue.main.async {
            self.dataSource?.apply(snapshot, animatingDifferences: true)
        }
    }
}

// MARK: - UITableViewDelegate
extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        presenter.getMovieDetail(id: movie.id)
    }
}

// MARK: - Private extension
private extension MovieListViewController {
    func configureTableView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.backgroundColor = .systemGray6
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        tableView.rowHeight = 120
        title = "Movies"
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        configureDataSource()
    }
    
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Movie>(
            tableView: tableView,
            cellProvider: {
                tableView, indexPath, movie in
                let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier,
                                                         for: indexPath) as? CustomCell
                cell?.setMovieCell(movie: movie, description: nil)
                return cell
            })
    }
}
