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
    let images: [ArtistImage]
    let href: String
    let genres: [String]
    let followers: followers
}

struct ArtistImage: Decodable {
    let height: Int
    let width: Int
    let url: String
}

struct followers: Decodable {
    let href: String?
    let total: Int
}
