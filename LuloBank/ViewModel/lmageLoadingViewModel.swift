//
//  lmageLoadingViewModel.swift
//  LuloBank
//
//  Created by Admin on 7/10/22.
//

import Foundation
import SwiftUI
import Combine

class ImageLoadingViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    var cancellable = Set<AnyCancellable>()
    
    let urlString : String
    
    init(url: String){
        urlString = url
        downloadImage()
    }
    
    func downloadImage(){
        isLoading = true
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map{UIImage(data: $0.data)}
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (_)in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &cancellable)
    }
    
}
