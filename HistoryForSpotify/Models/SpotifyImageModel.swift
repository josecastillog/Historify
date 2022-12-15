//
//  SpotifyImageModel.swift
//  HistoryForSpotify
//
//  Created by Jose Castillo on 12/15/22.
//

import Foundation

struct SpotifyImage: Decodable {
    let height: Int
    let width: Int
    let url: String
}
