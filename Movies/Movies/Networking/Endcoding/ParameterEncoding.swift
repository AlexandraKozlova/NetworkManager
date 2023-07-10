//
//  ParameterEncoding.swift
//  Movies
//
//  Created by Aleksandra on 18.01.2023.
//

import Foundation

protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: [String: Any]) throws
}

enum ParameterEncoding {
    case urlEncoding
    case jsonEncoding
    case urlAndJsonEncoding
    
    // MARK: - Encode
    func encode(urlRequest: inout URLRequest,
                bodyParameters: [String: Any]?,
                urlParameters: [String: Any]?) throws {
        do {
            switch self {
            case .urlEncoding:
                guard let urlParameters = urlParameters else { return }
                try URLParameterEncoder.encode(urlRequest: &urlRequest, with: urlParameters)
                
            case .jsonEncoding:
                guard let bodyParameters = bodyParameters else { return }
                try JSONParameterEncoder.encode(urlRequest: &urlRequest, with: bodyParameters)
                
            case .urlAndJsonEncoding:
                guard let bodyParameters = bodyParameters,
                      let urlParameters = urlParameters else { return }
                try URLParameterEncoder.encode(urlRequest: &urlRequest, with: urlParameters)
                try JSONParameterEncoder.encode(urlRequest: &urlRequest, with: bodyParameters)
            }
        } catch {
            throw error
        }
    }
}

// MARK: - NameOfError
enum NameOfError: String, Error {
    case unableToComplite = "Unable to complited your request. Please check your internet connection."
    case invalidResponse = "Ivalid response from server. Please, try again."
    case invalidData = "The data received from server was invalid. Please try again."
    case missingURL = "URL is nil."
    case encodingFailed = "Parameter encoding failed."
    
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}
