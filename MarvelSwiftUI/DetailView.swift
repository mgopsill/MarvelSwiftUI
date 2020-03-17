//
//  DetailView.swift
//  MarvelSwiftUI
//
//  Created by Mike Gopsill on 17/03/2020.
//  Copyright © 2020 Ford. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    let character: MarvelCharacter
    let image: LoadableImage
    
    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                image
                    .frame(width: 300, height: 300)
                    .background(Color.red)
                
                Text(character.description)
                    .font(Font.system(size: 12))
                    .lineLimit(nil)
                
                Button(action: {
                    UIApplication.shared.open(self.character.websiteURL!, options: [:], completionHandler: nil)
                }) {
                    Text("Website")
                        .font(Font.system(size: 16,
                                          weight: .semibold,
                                          design: .monospaced))
                }
                .padding()
                .background(Color.yellow)
                .cornerRadius(40)
            }
            .padding()
            .navigationBarTitle(character.name)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(character: MarvelCharacter(name: "Steve",
                                              description: "Description",
                                              thumbnail: Thumbnail(path: "a", thumbnailExtension: .jpg),
                                              urls: []),
                   image: LoadableImage(with: API.charactersURL))
    }
}
