//
//  MapModel.swift
//  MiniChallenge04
//
//  Created by Felipe Porto on 03/04/24.
//

import SwiftUI

struct StatePhoto: Codable, Equatable {
    let uf: String
    let foto: Data?
}

class StateInfoManager {
    static let shared = StateInfoManager()
    
    private let userDefaults = UserDefaults.standard
    private let key = "StatePhoto"
    
    func initializeStateInfos() {
        let StatePhotos: [StatePhoto] = [
            StatePhoto(uf: "AC", foto: nil),
            StatePhoto(uf: "AL", foto: nil),
            StatePhoto(uf: "AP", foto: nil),
            StatePhoto(uf: "AM", foto: nil),
            StatePhoto(uf: "BA", foto: nil),
            StatePhoto(uf: "CE", foto: nil),
            StatePhoto(uf: "DF", foto: nil),
            StatePhoto(uf: "ES", foto: nil),
            StatePhoto(uf: "GO", foto: nil),
            StatePhoto(uf: "MA", foto: nil),
            StatePhoto(uf: "MT", foto: nil),
            StatePhoto(uf: "MS", foto: nil),
            StatePhoto(uf: "MG", foto: nil),
            StatePhoto(uf: "PA", foto: nil),
            StatePhoto(uf: "PB", foto: nil),
            StatePhoto(uf: "PR", foto: nil),
            StatePhoto(uf: "PE", foto: nil),
            StatePhoto(uf: "PI", foto: nil),
            StatePhoto(uf: "RJ", foto: nil),
            StatePhoto(uf: "RN", foto: nil),
            StatePhoto(uf: "RS", foto: nil),
            StatePhoto(uf: "RO", foto: nil),
            StatePhoto(uf: "RR", foto: nil),
            StatePhoto(uf: "SC", foto: nil),
            StatePhoto(uf: "SP", foto: nil),
            StatePhoto(uf: "SE", foto: nil),
            StatePhoto(uf: "TO", foto: nil)
        ]
        
        saveStateInfos(StatePhotos)
    }
    
    
    private func saveStateInfos(_ StatePhotos: [StatePhoto]) {
        if let encodedData = try? JSONEncoder().encode(StatePhotos) {
            userDefaults.set(encodedData, forKey: key)
        }
    }
    
    func loadStateInfos() -> [StatePhoto] {
        if let savedData = userDefaults.data(forKey: key),
           let StatePhotos = try? JSONDecoder().decode([StatePhoto].self, from: savedData) {
            return StatePhotos
        }
        return []
    }
}
