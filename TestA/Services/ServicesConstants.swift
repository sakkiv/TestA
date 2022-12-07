//
//  AppConstants.swift
//  TestA
//
//  Created by vikas shankhdhar on 04/12/22.
//

import Foundation

struct Domain {
    static let dev = "https://raw.githubusercontent.com/obvious/take-home-exercise-data/trunk/nasa-pictures.json"

}
extension Domain {
    static func baseUrl() -> String {
        return Domain.dev
    }
}

enum HTTPHeaderField: String {
    case authentication  = "Authorization"
    case contentType     = "Content-Type"
    case acceptType      = "Accept"
    case acceptEncoding  = "Accept-Encoding"
    case acceptLangauge  = "Accept-Language"
}

enum ContentType: String {
    case json            = "application/json"
    case multipart       = "multipart/form-data"
    case ENUS            = "en-us"
}


enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case update = "UPDATE"
    case delete = "DELETE"
}

enum Result<Success, Failure> where Failure : Error {
    /// A success, storing a `Success` value.
    case success(Success)
    /// A failure, storing a `Failure` value.
    case failure(Failure)
}
