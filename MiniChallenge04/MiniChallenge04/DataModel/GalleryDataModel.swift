//
//  GalleryDataModel.swift
//  MiniChallenge04
//
//  Created by Luiz Felipe on 18/03/24.
//

import Foundation
import SwiftData
import SwiftUI
import Photos

@Model
class GalleryDataModel{
    var name:String
    
    init(name: String) {
        self.name = name
    }
//    var imagesGalleryUset : [String:[PHAsset]]
//    var userProfile: [Int]
//    
//    init( imagesGalleryUset: [String : [PHAsset]], userProfile: [Int]) {
//        self.imagesGalleryUset = imagesGalleryUset
//        self.userProfile = userProfile
//    }
}
