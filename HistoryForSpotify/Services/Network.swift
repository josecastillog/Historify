//
//  Network.swift
//  HistoryForSpotify
//
//  Created by Jose Castillo on 12/9/22.
//

import Foundation
import OAuthSwift
import UIKit

class Network: NSObject, ObservableObject {
    
    static let shared = Network()
    
    @Published var isAuthorized = false
    var keys = Secret()
    var oauthswift: OAuth2Swift
    
    @Published var artists: [Artist] = []
    @Published var tracks: [Track] = []
    
    override init() {
        self.oauthswift = OAuth2Swift(
            consumerKey:    keys.consumerKey,
            consumerSecret: keys.consumerSecret,
            authorizeUrl: keys.authorizeUrl,
            accessTokenUrl: keys.accessTokenUrl,
            responseType: "code"
        )
    }
    
    func authorize() {

        oauthswift.accessTokenBasicAuthentification = true

        guard let codeVerifier = generateCodeVerifier() else {return}
        guard let codeChallenge = generateCodeChallenge(codeVerifier: codeVerifier) else {return}

        oauthswift.authorize(
            withCallbackURL: "HistoryForSpotify://callback/",
            scope: "user-top-read",
            state:"State01",
            codeChallenge: codeChallenge,
            codeChallengeMethod: "S256",
            codeVerifier: codeVerifier) { result in
            switch result {
            case .success(let (credential, _, _)):
                print(credential.oauthToken)
                self.isAuthorized = true
                self.getTopArtists()
                self.getTopTracks()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getTopArtists() {
        oauthswift.client.get("https://api.spotify.com/v1/me/top/artists", parameters: ["limit": 50]) { result in
            switch result {
            case .success(let response):
                let data: Artists = try! JSONDecoder().decode(Artists.self, from: response.data)
                self.artists = data.items
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getTopTracks() {
        oauthswift.client.get("https://api.spotify.com/v1/me/top/tracks", parameters: ["limit": 50]) { result in
            switch result {
            case .success(let response):
                let data: Tracks = try! JSONDecoder().decode(Tracks.self, from: response.data)
                self.tracks = data.items
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
