//
//  DataItem.swift
//  MiniChallenge04
//
//  Created by Luiz Felipe on 18/03/24.
//

import Foundation
import SwiftData

@Model
class DataItem:Identifiable{
    var id:String
    
    init(id: String) {
        self.id = UUID().uuidString
    }
    
}
