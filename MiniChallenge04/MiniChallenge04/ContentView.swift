//
//  ContentView.swift
//  MiniChallenge04
//
//  Created by Daniel Ishida on 13/03/24.
//

import SwiftUI

struct ContentView: View {
    var api = APIManager()
    @State var places =  PlacesResponse(places: [])
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Button(action: {
                Task{
                    try await api.getTouristAttractions(city: "Rio de Janeiro")
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
