//
//  AlbumModel.swift
//  HistoryForSpotify
//
//  Created by Jose Castillo on 12/15/22.
//

import Foundation

struct Album: Decodable {
    
    let id: String
    let name: String
    let release_date: String
    let total_tracks: Int
    let uri: String
    let artists: [GenericArtist]
    let images: [SpotifyImage]
    
}
