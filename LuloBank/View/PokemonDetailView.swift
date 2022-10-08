//
//  PokemonDetailView.swift
//  LuloBank
//
//  Created by Admin on 8/10/22.
//

import SwiftUI

struct PokemonDetailView: View {
    @StateObject var loader : PokemonViewModel
    
    init(url:String) {
        _loader = StateObject(wrappedValue: PokemonViewModel(url: url, isDetail: true))
    }
    
    var body: some View {
        VStack(alignment:.leading){
            AsyncImage(url: URL(string: loader.PokemonDetail.sprites.frontDefault!)){ image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            
            Text(loader.PokemonDetail.name).font(.title.bold())
            
            Text("Habilidades").font(.title2).padding(.vertical)
            ForEach(loader.PokemonDetail.abilities, id: \.id){ index in
                HStack {
                    Image(systemName: "circle.fill").foregroundColor(.gray)
                    Text(index.ability.name)
                }
            }
            
            Spacer()
        }.padding()
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(url: "")
    }
}
