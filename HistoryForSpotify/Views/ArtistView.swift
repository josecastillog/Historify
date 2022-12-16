//
//  ArtistView.swift
//  HistoryForSpotify
//
//  Created by Jose Castillo on 12/14/22.
//

import SwiftUI

private let kArtist = Artist(id: "AAAA",
                             name: "Leiva",
                             popularity: 80,
                             uri: "example",
                             images: [SpotifyImage(height: 640, width: 640, url: "https://i.scdn.co/image/ab6761610000e5eb207b21f3ed0ee96adce3166a")],
                             href: "example",
                             genres: ["Rock"],
                             followers: Follwers(href: "", total: 845050))

struct ArtistView: View {
    
    @StateObject var network = Network.shared
    
    let columns = [GridItem(),
                   GridItem(),
                   GridItem()]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns) {
                ForEach(Array(zip(network.artists.indices, network.artists)), id: \.0) { index, artist in
                    VStack {
                        RoundedSquare(artist: artist, number: index)
                    }
                }
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical)
    }
}

struct ArtistView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistView()
    }
}
