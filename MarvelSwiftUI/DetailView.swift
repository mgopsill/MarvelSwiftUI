//
//  DetailView.swift
//  MarvelSwiftUI
//
//  Created by Mike Gopsill on 18/03/2020.
//  Copyright © 2020 Ford. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    let character: MarvelCharacter
    
    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                LoadableImage(url: character.imageURL)
                    .frame(width: 300, height: 300)
                Text(character.name)
                    .font(Font.system(size: 20, weight: .bold, design: .default))
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
        // Mock Character
        DetailView(character: MarvelCharacter(name: "Kevin",
                                              description: "Legend",
                                              thumbnail: Thumbnail(path: "", thumbnailExtension: .jpg),
                                              urls: []))
    }
}
