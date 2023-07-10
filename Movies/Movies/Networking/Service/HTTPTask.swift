//
//  HTTPTask.swift
//  Movies
//
//  Created by Aleksandra on 18.01.2023.
//

import Foundation

enum HTTPTask {
    case requestHeaders(additionHeaders: HTTPHeaders?)

    case requestParametersAndHeaders(bodyParameters: [String: Any]?,
                                     bodyEncoding: ParameterEncoding,
                                     urlParameters: [String: Any]?,
                                     additionHeaders: HTTPHeaders?)
}
