//
//  TrackRowView.swift
//  HistoryForSpotify
//
//  Created by Jose Castillo on 12/15/22.
//

import SwiftUI

// Constants for preview
private let kImage = SpotifyImage(height: 64, width: 64, url: "")

private let kArtist = GenericArtist(id: "", name: "", uri: "", href: "")

private let kAlbum = Album(id: "",
                          name: "",
                          release_date: "",
                          total_tracks: 10,
                          uri: "",
                          artists: [kArtist],
                          images: [kImage, kImage, kImage])

private let kTrack = Track(id: "",
                          name: "",
                          popularity: 80,
                          preview_url: "",
                          track_number: 2,
                          uri: "",
                          album: kAlbum,
                          artists: [kArtist],
                          duration_ms: 2000)

struct TrackRowView: View {
    
    let trackNum: Int
    let track: Track
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            HStack(spacing: 8) {
                Text("#\(trackNum+1)")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color("WhiteBlack"))
                    .frame(width: 58)
                HStack(spacing: 16) {
                    AsyncImage(
                        url: URL(string: track.album.images[2].url),
                        content: { image in
                            image.resizable()
                                 .aspectRatio(contentMode: .fill)
                                 .frame(width: 55, height: 55)
                                 .clipShape(RoundedRectangle(cornerRadius: 16))
                        },
                        placeholder: {
                            RoundedRectangle(cornerRadius: 18)
                                .frame(width: 55, height: 55)
                        }
                    )
                    VStack(alignment: .leading, spacing: 1) {
                        HStack(spacing: 6) {
                            Text(track.name)
                                .font(.headline).bold()
                                .foregroundColor(Color(.white))
                                .lineLimit(1)
                        }
                        Text(track.artists[0].name)
                            .font(.subheadline)
                            .foregroundColor(Color(.white))
                            .lineLimit(1)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 12)
                .padding(.horizontal, 15)
                .background(Color("CustomGray"))
                .clipShape(RoundedRectangle(cornerRadius: 25))
            }
        }
    }
}

struct TrackRowView_Previews: PreviewProvider {
    static var previews: some View {
        TrackRowView(trackNum: 1, track: kTrack)
    }
}
