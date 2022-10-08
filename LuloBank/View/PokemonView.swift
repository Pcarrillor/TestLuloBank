//
//  PokemonView.swift
//  LuloBank
//
//  Created by Admin on 8/10/22.
//

import SwiftUI

struct PokemonView: View {
    @StateObject var loader : PokemonViewModel
    @State var multiview : Bool = true
    
    init(url: String){
        _loader = StateObject(wrappedValue: PokemonViewModel(url: url, isDetail: false))
    }
    let gridItem = [GridItem(),GridItem()]
    let gridItem1 = [GridItem()]
    
    var body: some View {
        NavigationView {
            VStack {
                
                HStack{
                    Spacer()
                    Button {
                        multiview = true
                    } label: {
                        Image(systemName: "square.grid.2x2").resizable().scaledToFit()
                    }.frame(width:30)
                    
                    Button {
                        multiview = false
                    } label: {
                        Image(systemName: "rectangle.grid.1x2").resizable().scaledToFit()
                    }.frame(width:30)
                }.foregroundColor(.gray).padding(.horizontal).padding(.top)
                
                ScrollView {
                    
                    LazyVGrid(columns: multiview == true ? gridItem : gridItem1) {
                        ForEach(loader.Pokemonall.results, id: \.self) { pokemon in
                            let index = loader.Pokemonall.results.firstIndex(of: pokemon)
                            NavigationLink {
                                PokemonDetailView(url: pokemon.url)
                            } label: {
                                PokemonCell(name: pokemon.name, index : index!).frame(height:170)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView(url: "")
    }
}

struct PokemonCell: View {
    let name: String
    let index : Int
    var body: some View {
        HStack{
            Spacer()
            VStack{
                Text(name)
                ImageLoadingView(url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(index+1).png")
            }
            Spacer()
        }
        .padding()
        .foregroundColor(.black)
        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.white).shadow(radius: 1)).padding()
    }
}
