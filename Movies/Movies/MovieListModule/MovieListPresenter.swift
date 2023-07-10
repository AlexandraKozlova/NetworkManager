//
//  MovieListPresenter.swift
//  Movies
//
//  Created by Aleksandra on 26.12.2022.
//

import Foundation

protocol MovieListPresenterDelegate: AnyObject {
    func updateMovieList(with movies: [Movie])
    func updateMovieDetail(with movie: MovieDetail)
    func showError(with error: NameOfError)
}

final class MovieListPresenter {
    // MARK: - Internal properties
    weak var delegate: MovieListPresenterDelegate?
    
    // MARK: - Private properties
    private var model = MovieListModel()
    
    // MARK: - Methods
    func getMovies() {
        model.getMovieList { [weak self] result in
            switch result {
            case .success(let movies):
                self?.delegate?.updateMovieList(with: movies)
            case .failure(let error):
                self?.delegate?.showError(with: error)
            }
        }
    }
    
    func getMovieDetail(id: String) {
        model.getMovieDetail(id: id) { [weak self] result in
            switch result {
            case .success(let movieDetail):
                self?.delegate?.updateMovieDetail(with: movieDetail)
            case .failure(let error):
                self?.delegate?.showError(with: error)
            }
        }
    }
}
