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
    let photos : [Photos]
}

struct DisplayName: Codable {
    let text: String
    let languageCode: String
}

struct EditorialSummary: Codable {
    let text : String
    let languageCode: String
}

struct Photos : Codable{
    let name : String
    let widthPX : Int
    let heightPx: Int
    let authorAttributions : [AuthorAttribution]
}

struct AuthorAttribution: Codable {
    let displayName: String
    let uri: String
    let photoUri: String
}



struct PlacesResponse: Codable {
    let places: [Place]
}
