//
//  APIError.swift
//  WeatherApp
//
//  Created by Divesh Singh on 2/28/21.
//

import Foundation

enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    case decoding
    case invalidURL
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        case .decoding: return "An error occurred while decoding data"
        case .invalidURL : return "Please check server end point"
        }
    }
}
