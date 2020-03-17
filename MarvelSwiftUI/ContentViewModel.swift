//
//  ContentViewModel.swift
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
