//
//  RoundedSquare.swift
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

struct RoundedSquare: View {
    
    let artist: Artist
    let number: Int
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 0) {
                AsyncImage(
                    url: URL(string: artist.images[0].url),
                    content: { image in
                        image.resizable()
                             .aspectRatio(contentMode: .fill)
                             .frame(width: 112, height: 112)
                             .clipShape(RoundedRectangle(cornerRadius: 20))
                    },
                    placeholder: {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 112, height: 112)
                    }
                )
                Text("\(number+1). \(artist.name)")
                    .font(.caption).bold()
                    .padding(.leading, 10)
                    .padding(.top, 5)
                    .frame(maxWidth: 112, alignment: .leading)
                    .fixedSize(horizontal: true, vertical: true)
            }
        }
    }
}

struct RoundedSquare_Previews: PreviewProvider {
    static var previews: some View {
        RoundedSquare(artist: kArtist, number: 1)
    }
}
