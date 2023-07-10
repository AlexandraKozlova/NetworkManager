//
//  EndPointType.swift
//  Movies
//
//  Created by Aleksandra on 30.12.2022.
//

import Foundation

typealias HTTPHeaders = [String: String]

protocol EndPointType {
    var baseURL: URL { get }
    var path: String? { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var task: HTTPTask { get }
}
