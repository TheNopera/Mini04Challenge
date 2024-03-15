//
//  PlacesModel.swift
//  MiniChallenge04
//
//  Created by Daniel Ishida on 14/03/24.
//

import Foundation

struct Place: Codable {
    let editorialSummary: EditorialSummary
    let displayName: DisplayName
}

struct DisplayName: Codable {
    let text: String
    let languageCode: String
}

struct EditorialSummary: Codable {
    let text: String
    let languageCode: String
}

struct PlacesResponse: Codable {
    let places: [Place]
}
