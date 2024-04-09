//
//  MapViewModel.swift
//  MiniChallenge04
//
//  Created by Lucas Nascimento on 25/03/24.
//

import Foundation
import SwiftUI

class MapViewModel:ObservableObject{
    var uf:String = ""
    @State var ufs = ["AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA", "MT", "MS", "MG", "PA", "PB", "PR", "PE", "PI", "RJ", "RN", "RS", "RO", "RR", "SC", "SP", "SE", "TO"]
}
