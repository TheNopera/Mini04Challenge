//
//  MiniChallenge04App.swift
//  MiniChallenge04
//
//  Created by Daniel Ishida on 13/03/24.
//

import SwiftUI
import GooglePlaces
class BaseEnv{
    let dict : NSDictionary
    
    init(resourceName : String){
        guard let filePath = Bundle.main.path(forResource: resourceName, ofType: "plist") else{
            fatalError("Couldn't find \(resourceName) filepath")
        }
        
        guard let plist = NSDictionary(contentsOfFile: filePath) else{
            fatalError("Couldn't read contents of \(filePath)")
        }
        
        self.dict = plist
    }
}

protocol APIKeyable{
    var SERVICE_API_KEY : String {get}
}

class ProdENV: BaseEnv, APIKeyable{
    var SERVICE_API_KEY: String{
        dict.object(forKey: "GOOGLE_PLACES_API_KEY") as? String ?? ""
    }
    
    init() {
        super.init(resourceName: "PROD-Keys")
    }
}

//MARK: APP DELEGATE AND MAIN

class AppDelegate: NSObject, UIApplicationDelegate {
    var ENV : APIKeyable {
        return ProdENV()
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        GMSPlacesClient.provideAPIKey(ENV.SERVICE_API_KEY)
        return true
    }
}


@main
struct MiniChallenge04App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {

            OmboardingView()

        }
    }
}
