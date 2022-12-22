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
    @State private var selectedFilter: FilterViewModel = .weeks
    @Namespace var animation
    
    var body: some View {
        VStack(spacing: 0) {
            filterBar
                .padding(.top, 6)
            switch selectedFilter {
            case .weeks:
                ArtistScrollView(artists: network.artistsWeeks)
            case .months:
                ArtistScrollView(artists: network.artistsMonths)
            case .allTime:
                ArtistScrollView(artists: network.artistsAllTime)
            }
        }
    }
}

struct ArtistView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistView()
    }
}

extension ArtistView {
    
    var filterBar : some View {
        HStack {
            ForEach(FilterViewModel.allCases, id: \.rawValue) { item in
                VStack {
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == item ? .semibold : .regular)
                        .foregroundColor(selectedFilter == item ? Color("WhiteBlack") : .gray)
                    
                    if selectedFilter == item {
                        Capsule()
                            .foregroundColor(Color("CustomGreen"))
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    } else {
                        Capsule()
                            .foregroundColor(Color(.clear))
                            .frame(height: 3)
                    }
                }.onTapGesture {
                    withAnimation(.default) {
                        self.selectedFilter = item
                    }
                }
            }
        }
        .overlay(Divider().offset(x: 0, y: 16))
    }
    
}

struct ArtistScrollView: View {
    
    let artists: [Artist]
    
    var body: some View {
        
        let columns = [GridItem(),
                       GridItem(),
                       GridItem()]
        
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(Array(zip(artists.indices, artists)), id: \.0) { index, artist in
                    VStack {
                        RoundedSquare(artist: artist, number: index)
                    }
                    .padding(.top)
                }
            }
            .padding(.bottom)
        }
        .padding(.horizontal, 8)
    }
}
