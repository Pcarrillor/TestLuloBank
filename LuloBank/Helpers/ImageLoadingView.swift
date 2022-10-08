//
//  ImageLoadingView.swift
//  LuloBank
//
//  Created by Admin on 7/10/22.
//

import SwiftUI

struct ImageLoadingView: View {
    @StateObject var loader : ImageLoadingViewModel
    
    init(url: String){
        _loader = StateObject(wrappedValue: ImageLoadingViewModel(url: url))
    }
    
    var body: some View {
        if loader.isLoading{
            ProgressView()
        }else if let image = loader.image{
            Image(uiImage: image).resizable().scaledToFit()
        }
    }
}

struct ImageLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        ImageLoadingView(url: "")
    }
}
