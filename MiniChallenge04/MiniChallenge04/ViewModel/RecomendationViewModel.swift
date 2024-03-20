//
//  RecomendationViewModel.swift
//  MiniChallenge04
//
//  Created by Felipe Porto on 20/03/24.
//

import Foundation
import SwiftUI

class RecomendationViewModel: ObservableObject {
    @Published var recomendationModel: RecomendationModel
    
    init() {
        self.recomendationModel = RecomendationModel()
    }
}
