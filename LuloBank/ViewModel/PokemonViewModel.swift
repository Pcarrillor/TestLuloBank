//
//  PokemonViewModel.swift
//  LuloBank
//
//  Created by Admin on 8/10/22.
//

import Foundation
//import SwiftyJSON
import Combine

class PokemonViewModel : ObservableObject{
    @Published var Pokemonall = PokemonAll()
    @Published var PokemonDetail = Pokemon()
    let urlQuery: String
    var cancellables = Set<AnyCancellable>()
    
    init(url:String, isDetail:Bool){
        urlQuery = url
        if !isDetail {
            getPokemons()
        }else{
            getPokemonDetail()
        }
    }
    
    func getPokemons(){
        guard let url = URL(string: urlQuery) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else{
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: PokemonAll.self, decoder: JSONDecoder())
            .sink { (completion) in
                print("Completion: \(completion)")
            } receiveValue: { [weak self] returnedPokemons in
                self?.Pokemonall = returnedPokemons
                print(self!.Pokemonall)
            }
            .store(in: &cancellables)
        
    }
    
    func getPokemonDetail(){
        guard let url = URL(string: urlQuery) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else{
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: Pokemon.self, decoder: JSONDecoder())
            .sink { (completion) in
                print("Completion: \(completion)")
            } receiveValue: { [weak self] returnedPokemons in
                self?.PokemonDetail = returnedPokemons
                print(self!.PokemonDetail)
            }
            .store(in: &cancellables)
        
    }
    
}
