//
//  NetworkService.swift
//  fetch-coding-challenge
//
//  Created by Yoseob Lee on 8/26/24.
//

import Foundation

final class NetworkService: ObservableObject {

    private let decoder = JSONDecoder()

    func request<T: Decodable>(endpoint: EndpointProviding) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: endpoint.asURLRequest())
        return try decodeResponse(data: data, response: response)
    }

    private func decodeResponse<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        guard let response = response as? HTTPURLResponse else {
            throw APIError(errorCode: "Error-0", message: "Invalid url response")
        }

        switch response.statusCode {
        case 200...299:
            return try decoder.decode(T.self, from: data)
        default:
            guard let decodedError = try? decoder.decode(APIError.self, from: data) else {
                throw APIError(statusCode: response.statusCode, errorCode: "Error-0", message: "Unknown error type")
            }

            throw APIError(statusCode: response.statusCode, errorCode: decodedError.errorCode, message: decodedError.message)
        }
    }
}
