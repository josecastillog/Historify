//
//  TrackModel.swift
//  HistoryForSpotify
//
//  Created by Jose Castillo on 12/15/22.
//

import Foundation

struct Tracks: Decodable {
    let items: [Track]
}


struct Track: Decodable, Identifiable {
    
    let id: String
    let name: String
    let popularity: Int
    let preview_url: String?
    let track_number: Int
    let uri: String
    let album: Album
    let artists: [GenericArtist]
    let duration_ms: Int
    
}
