//
//  ArtistModel.swift
//  HistoryForSpotify
//
//  Created by Jose Castillo on 12/14/22.
//

import Foundation

struct Artists: Decodable {
    let items: [Artist]
}

struct Artist: Decodable, Identifiable {
    let id: String
    let name: String
    let popularity: Int
    let uri: String
    let images: [SpotifyImage]
    let href: String
    let genres: [String]
    let followers: Follwers
}

struct Follwers: Decodable {
    let href: String?
    let total: Int
}
