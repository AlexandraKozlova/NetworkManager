//
//  Movies.swift
//  Movies
//
//  Created by Aleksandra on 30.12.2022.
//

import Foundation

enum Movies {
    case moviesList
    case movieDetail(id: String)
    case postMovie
}

extension Movies: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: Constants.baseURL) else {
            fatalError("baseURL could not be configured.")
        }
        switch self {
        default: return url
        }
    }
    
    var path: String? {
        switch self {
        case .moviesList:
            return nil
        case .movieDetail(let id):
            return "/\(id)"
        case .postMovie:
            return "post_movie"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .moviesList:
            return .get
        case .movieDetail:
            return .get
        case .postMovie:
            return .post
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .moviesList:
            return Constants.headers
        case .movieDetail:
            return Constants.headers
        case .postMovie:
            return Constants.headers
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .postMovie:
            return .requestParametersAndHeaders(bodyParameters: ["name": "New one"],
                                                bodyEncoding: .urlAndJsonEncoding,
                                                urlParameters: ["key": "value"],
                                                additionHeaders: headers)
        default:
            return .requestHeaders(additionHeaders: self.headers)
        }
    }
}

fileprivate struct Constants{
    static let baseURL = "https://imdb-top-100-movies.p.rapidapi.com/premiummovies"
    static let headers =  ["X-RapidAPI-Key": "24f310c8dcmsh5ef7c433a099fdfp1d08b6jsn02ad4117138b",
                           "X-RapidAPI-Host": "imdb-top-100-movies.p.rapidapi.com"]
}
