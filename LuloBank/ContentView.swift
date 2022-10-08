//
//  ContentView.swift
//  LuloBank
//
//  Created by Admin on 7/10/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        PokemonView(url: "https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
