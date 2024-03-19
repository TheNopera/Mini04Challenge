//
//  PlacesModel.swift
//  MiniChallenge04
//
//  Created by Daniel Ishida on 14/03/24.
//

import Foundation

struct Photo: Codable {
    let name: String
    let widthPx: Int
    let heightPx: Int
    let authorAttributions: [AuthorAttribution]
}

struct AuthorAttribution: Codable {
    let displayName: String
    let uri: String
    let photoUri: String
}

struct EditorialSummary: Codable {
    let text: String
    let languageCode: String
}

struct DisplayName: Codable {
    let text: String
    let languageCode: String
}

struct Place: Codable {
    let displayName: DisplayName
    let editorialSummary: EditorialSummary
    let photos: [Photo]
}

struct PlacesResponse: Codable {
    let places: [Place]
}
