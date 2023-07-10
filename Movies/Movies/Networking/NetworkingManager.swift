//
//  NetworkingManager.swift
//  Movies
//
//  Created by Aleksandra on 25.11.2022.
//

import Foundation

final class NetworkManager {
    // MARK: - Private methods
    private let router = Router<Movies>()
    
    // MARK: - GetMoviesList
    func getMoviesList(completion: @escaping (Result <[Movie], NameOfError>) -> Void) {
        router.request(.moviesList) { data, response, error in
            if error != nil {
                completion(.failure(.unableToComplite))
            }
            
            if let response = response as? HTTPURLResponse {
                let errorWithResponse = self.handleNetworkResponse(response)
                if errorWithResponse == nil {
                    guard let responseData = data else {
                        completion(.failure(.invalidResponse))
                        return
                    }
                    do {
                        let jsonData = try JSONSerialization.jsonObject(with: responseData,
                                                                        options: .mutableContainers)
                      
                        let apiResponse = try JSONDecoder().decode([Movie].self,
                                                                   from: responseData)
                        
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(.invalidData))
                    }
                } else {
                    guard let error = errorWithResponse else { return }
                    completion(.failure(error))
                }
            }
        }
    }
    
    // MARK: - GetMovieDetail
    func getMovieDetail(id: String, completion: @escaping (Result <MovieDetail, NameOfError>) -> Void) {
        router.request(.movieDetail(id: id)) { data, response, error in
            if error != nil {
                completion(.failure(.unableToComplite))
            }
            
            if let response = response as? HTTPURLResponse {
                let errorWithResponse = self.handleNetworkResponse(response)
                if errorWithResponse == nil {
                    guard let responseData = data else {
                        completion(.failure(.invalidResponse))
                        return
                    }
                    do {
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        
                        let apiResponse = try JSONDecoder().decode(MovieDetail.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(.invalidData))
                    }
                } else {
                    guard let error = errorWithResponse else { return }
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> NameOfError? {
        switch response.statusCode {
        case 200...299: return nil
        case 401...500: return NameOfError.authenticationError
        case 501...599: return NameOfError.badRequest
        case 600: return NameOfError.outdated
        default: return NameOfError.failed
        }
    }
}
