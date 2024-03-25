//
//  OmboardingViewModel.swift
//  MiniChallenge04
//
//  Created by Luiz Felipe on 21/03/24.
//

import Foundation
import SwiftUI

class OmboardingViewModel:ObservableObject{
    @Published var numberOfCircle=[1,2,3]
    @Published var imagesOmboardingForm:[String] = ["aa","a","s","d","5","8"]
    var adaptiveColuns = [GridItem(.adaptive(minimum: 120, maximum: 200))]

    func changeColor(color:Color) -> Color{
        return color
    }
    
    
}
