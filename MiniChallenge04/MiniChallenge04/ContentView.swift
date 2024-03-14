//
//  ContentView.swift
//  MiniChallenge04
//
//  Created by Daniel Ishida on 13/03/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var api = APIManager()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Button(action: {
                Task{
                     api.getTouristAttractions(city: "Rio de Janeiro")
                }
            }, label: {
                Text("get info about Rio")
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
