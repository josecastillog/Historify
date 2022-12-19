//
//  Network.swift
//  HistoryForSpotify
//
//  Created by Jose Castillo on 12/9/22.
//

import Foundation
import OAuthSwift
import UIKit
import Prephirences

class Network: NSObject, ObservableObject {
    
    static let shared = Network()
    
    var keychain = KeychainPreferences.sharedInstance
    
    var keys = Secret()
    var oauthswift: OAuth2Swift
    
    @Published var isAuthorized = true
    @Published var artistsWeeks: [Artist] = []
    @Published var artistsMonths: [Artist] = []
    @Published var artistsAllTime: [Artist] = []
    @Published var tracksWeeks: [Track] = []
    @Published var tracksMonths: [Track] = []
    @Published var tracksAllTime: [Track] = []
    
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
            case .success:
                self.isAuthorized = true
                self.save()
                self.getTopArtists()
                self.getTopTracks()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func refreshToken() {
        oauthswift.client.renewAccessToken(accessTokenUrl: "https://accounts.spotify.com/api/token",
                                           withRefreshToken: oauthswift.client.credential.oauthRefreshToken) { result in
            switch result {
            case .success:
                print("DEBUG: Token refresh success")
                self.getTopTracks()
                self.getTopArtists()
                self.save()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getTopArtists() {
        self.getTopArtistsWeeks()
        self.getTopArtistsMonths()
        self.getTopArtistsAllTime()
    }
    
    func getTopTracks() {
        self.getTopTracksWeeks()
        self.getTopTracksMonths()
        self.getTopTracksAllTime()
    }
    
    func getTopArtistsWeeks() {
        oauthswift.client.get("https://api.spotify.com/v1/me/top/artists", parameters: ["limit": 50, "time_range": "short_term"]) { result in
            switch result {
            case .success(let response):
                let data: Artists = try! JSONDecoder().decode(Artists.self, from: response.data)
                self.artistsWeeks = data.items
            case .failure(let error):
                if case .tokenExpired = error {
                    self.refreshToken()
                } else {
                    print(error)
                }
            }
        }
    }
    
    func getTopArtistsMonths() {
        oauthswift.client.get("https://api.spotify.com/v1/me/top/artists", parameters: ["limit": 50, "time_range": "medium_term"]) { result in
            switch result {
            case .success(let response):
                let data: Artists = try! JSONDecoder().decode(Artists.self, from: response.data)
                self.artistsMonths = data.items
            case .failure(let error):
                if case .tokenExpired = error {
                    self.refreshToken()
                } else {
                    print(error)
                }
            }
        }
    }
    
    func getTopArtistsAllTime() {
        oauthswift.client.get("https://api.spotify.com/v1/me/top/artists", parameters: ["limit": 50, "time_range": "long_term"]) { result in
            switch result {
            case .success(let response):
                let data: Artists = try! JSONDecoder().decode(Artists.self, from: response.data)
                self.artistsAllTime = data.items
            case .failure(let error):
                if case .tokenExpired = error {
                    self.refreshToken()
                } else {
                    print(error)
                }
            }
        }
    }
    
    func getTopTracksWeeks() {
        oauthswift.client.get("https://api.spotify.com/v1/me/top/tracks", parameters: ["limit": 50, "time_range": "short_term"]) { result in
            switch result {
            case .success(let response):
                let data: Tracks = try! JSONDecoder().decode(Tracks.self, from: response.data)
                self.tracksWeeks = data.items
            case .failure(let error):
                if case .tokenExpired = error {
                    self.refreshToken()
                } else {
                    print(error)
                }
            }
        }
    }
    
    func getTopTracksMonths() {
        oauthswift.client.get("https://api.spotify.com/v1/me/top/tracks", parameters: ["limit": 50, "time_range": "medium_term"]) { result in
            switch result {
            case .success(let response):
                let data: Tracks = try! JSONDecoder().decode(Tracks.self, from: response.data)
                self.tracksMonths = data.items
            case .failure(let error):
                if case .tokenExpired = error {
                    self.refreshToken()
                } else {
                    print(error)
                }
            }
        }
    }
    
    func getTopTracksAllTime() {
        oauthswift.client.get("https://api.spotify.com/v1/me/top/tracks", parameters: ["limit": 50, "time_range": "long_term"]) { result in
            switch result {
            case .success(let response):
                let data: Tracks = try! JSONDecoder().decode(Tracks.self, from: response.data)
                self.tracksAllTime = data.items
            case .failure(let error):
                if case .tokenExpired = error {
                    self.refreshToken()
                } else {
                    print(error)
                }
            }
        }
    }
    
    func save() {
        keychain["spotify_credential", .archive] = self.oauthswift.client.credential
    }
    
    func read() {
        
        if let credential = keychain["spotify_credential"] as? OAuthSwiftCredential {
            self.oauthswift.client.credential.oauthToken = credential.oauthToken
            self.oauthswift.client.credential.oauthTokenSecret = credential.oauthTokenSecret
            self.oauthswift.client.credential.oauthRefreshToken = credential.oauthRefreshToken
            isAuthorized = true
            self.getTopArtists()
            self.getTopTracks()
        } else {
            isAuthorized = false
        }

    }
}
