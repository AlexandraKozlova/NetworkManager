//
//  NetworkRouter.swift
//  Movies
//
//  Created by Aleksandra on 18.01.2023.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter: AnyObject {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

final class Router<EndPoint: EndPointType>: NetworkRouter {
    //MARK: - Private properties
    private var task: URLSessionTask?
    
    //MARK: - Internal methods
    func request (_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                completion (data, response, error)
            })
        } catch {
            completion (nil, nil, error)
        }
        self.task?.resume ( )
    }
    
    func cancel() {
        self.task?.cancel()
    }
}

// MARK: - Private network setup
private extension NetworkRouter {
    func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path ?? ""))
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestHeaders(additionHeaders: let additionHeaders):
                self.addAdditionalHeaders(additionHeaders, request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    func configureParameters(bodyParameters: [String: Any]?,
                             bodyEncoding: ParameterEncoding,
                             urlParameters: [String: Any]?,
                             request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
