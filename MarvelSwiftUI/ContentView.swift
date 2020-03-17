//
//  ContentView.swift
//  MarvelSwiftUI
//
//  Created by Mike Gopsill on 17/03/2020.
//  Copyright © 2020 Ford. All rights reserved.
//

import Combine
import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.characters, id: \.id) { character in
                NavigationLink(destination: DetailView(character: character)) {
                    HStack {
                        LoadableImage(with: character.imageURL)
                            .frame(width: 50, height: 50)
                        Text(character.name)
                    }
                }
            }
            .navigationBarTitle("Marvel")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
