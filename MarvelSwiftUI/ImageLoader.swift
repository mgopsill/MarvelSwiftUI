//
//  ImageLoader.swift
//  MarvelSwiftUI
//
//  Created by Mike Gopsill on 18/03/2020.
//  Copyright © 2020 Ford. All rights reserved.
//

import Combine
import SwiftUI

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
