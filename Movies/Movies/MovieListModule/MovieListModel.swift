//
//  MovieListModel.swift
//  Movies
//
//  Created by Aleksandra on 26.12.2022.
//

import Foundation

final class MovieListModel {
    // MARK: - Private properties
    private var networkManager = NetworkManager()
    
    // MARK: - Internal methods
    func getMovieList(completed: @escaping (Result <[Movie], NameOfError>) -> Void) {
        networkManager.getMoviesList { result in
            switch result {
            case .success(let movies):
                completed(.success(movies))
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
    
    func getMovieDetail(id: String,
                        completed: @escaping (Result <MovieDetail, NameOfError>) -> Void) {
        networkManager.getMovieDetail(id: id) { result in
            switch result {
            case .success(let movieDetail):
                completed(.success(movieDetail))
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
}
