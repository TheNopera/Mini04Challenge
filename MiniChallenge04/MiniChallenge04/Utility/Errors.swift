//
//  Errors.swift
//  MiniChallenge04
//
//  Created by Daniel Ishida on 13/03/24.
//

import Foundation

enum APIError : Error{
    case invalidURL
    case invalidResponse(String)
    case invalidData(String)
}
