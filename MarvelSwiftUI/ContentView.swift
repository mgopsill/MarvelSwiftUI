//
//  ContentView.swift
//  MarvelSwiftUI
//
//  Created by Mike Gopsill on 17/03/2020.
//  Copyright © 2020 Ford. All rights reserved.
//

import Combine
import SwiftUI

final class ContentViewModel: ObservableObject {
    @Published var characters: [MarvelCharacter] = []
    
    var charactersCancellable: AnyCancellable?
    
    init() {
        charactersCancellable = URLSession.shared.dataTaskPublisher(for: API.charactersURL)
            .map { $0.data }
            .decode(type: CharacterResponseModel.self, decoder: JSONDecoder())
            .map { $0.data.characters }
            .receive(on: RunLoop.main)
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .assign(to: \.characters, on: self)
    }
}

final class ImageLoader: ObservableObject {
    @Published var image: Image?
    var cancellable: AnyCancellable?
    
    init(url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .compactMap { UIImage(data: $0) }
            .map { Image(uiImage: $0) }
            .receive(on: RunLoop.main)
            .replaceError(with: nil)
            .eraseToAnyPublisher()
            .assign(to: \.image, on: self)
    }
}

struct LoadableImage: View {
    @ObservedObject var imageLoader: ImageLoader
    
    init(with url: URL) {
        imageLoader = ImageLoader(url: url)
    }
    
    var body: some View {
        if let image = imageLoader.image {
            return AnyView(
                image.resizable()
            )
        } else {
            return AnyView(
                ActivityIndicator(style: .medium)
            )
        }
    }
}

struct ContentView: View {
    @ObservedObject private var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.characters, id: \.id) { character in
                NavigationLink(destination: DetailView(character: character, image: LoadableImage(with: character.imageURL))) {
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

struct ActivityIndicator: UIViewRepresentable {
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        uiView.startAnimating()
    }
}
