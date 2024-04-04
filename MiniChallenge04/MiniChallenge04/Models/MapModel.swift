import SwiftUI

struct StatePhoto: Codable, Equatable {
    let uf: String
    var foto: Data? // Alterado para var
}

class StateInfoManager {
    static let shared = StateInfoManager()
    
    private let userDefaults = UserDefaults.standard
    private let key = "StatePhoto"
    
    func initializeStateInfos() {
        let statePhotos: [StatePhoto] = [
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
        
        saveStateInfos(statePhotos)
    }
    
    private func saveStateInfos(_ statePhotos: [StatePhoto]) {
        if let encodedData = try? JSONEncoder().encode(statePhotos) {
            userDefaults.set(encodedData, forKey: key)
        }
    }
    
    func loadStateInfos() -> [StatePhoto] {
        if let savedData = userDefaults.data(forKey: key),
           let statePhotos = try? JSONDecoder().decode([StatePhoto].self, from: savedData) {
            return statePhotos
        }
        return []
    }
    
    func updateStateFoto(forUF uf: String, withFoto foto: Data) {
        var stateInfos = loadStateInfos()
        if let index = stateInfos.firstIndex(where: { $0.uf == uf }) {
            stateInfos[index].foto = foto
            saveStateInfos(stateInfos)
        }
    }
    
    func getStateFoto(forUF uf: String) -> Data? {
            // Carregue os StatePhotos
            let statePhotos = loadStateInfos()
            // Encontre o StatePhoto correspondente ao UF especificado
            if let statePhoto = statePhotos.first(where: { $0.uf == uf }) {
                return statePhoto.foto
            }
            return nil
        }
}
