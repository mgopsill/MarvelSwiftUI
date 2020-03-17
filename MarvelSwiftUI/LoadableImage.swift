//
//  LoadableImage.swift
//  MarvelSwiftUI
//
//  Created by Mike Gopsill on 17/03/2020.
//  Copyright © 2020 Ford. All rights reserved.
//

import SwiftUI

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
