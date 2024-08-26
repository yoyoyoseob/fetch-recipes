//
//  APIError.swift
//  fetch-coding-challenge
//
//  Created by Yoseob Lee on 8/26/24.
//

struct APIError: Error, Decodable {
    let statusCode: Int
    let errorCode: String
    let message: String

    init(statusCode: Int = 0, errorCode: String, message: String) {
        self.statusCode = statusCode
        self.errorCode = errorCode
        self.message = message
    }
}
