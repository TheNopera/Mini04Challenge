//
//  FormDataModel.swift
//  MiniChallenge04
//
//  Created by Luiz Felipe on 18/03/24.
//

import Foundation
import SwiftData

@Model
class FormDataModel{
    var geography:String
    var weather:String
    
    init(geography: String, weather: String) {
        self.geography = geography
        self.weather = weather
    }
}
