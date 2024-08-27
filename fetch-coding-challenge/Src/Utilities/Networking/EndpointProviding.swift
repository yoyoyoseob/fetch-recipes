//
//  EndpointProviding.swift
//  fetch-coding-challenge
//
//  Created by Yoseob Lee on 8/26/24.
//

import Foundation

protocol EndpointProviding {
    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var body: [String: Any]? { get }
}

extension EndpointProviding {
    var scheme: String { "https" }

    func asURLRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = scheme
        components.host = baseURL
        components.path = path
        components.queryItems = queryItems

        guard let url = components.url else {
            throw APIError(errorCode: "Error-0", message: "Could not construct valid url from components")
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue.uppercased()
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        if let body = body {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        }

        return request
    }
}
