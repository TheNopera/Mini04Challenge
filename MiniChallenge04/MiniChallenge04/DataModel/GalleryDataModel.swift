//
//  GalleryDataModel.swift
//  MiniChallenge04
//
//  Created by Luiz Felipe on 18/03/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class GalleryDataModel:Identifiable{
    var id = UUID()
    
    @Attribute(.externalStorage)
    var image:Data
    
    init(id: UUID = UUID(), image: Data) {
        self.id = id
        self.image = image
    }
}
