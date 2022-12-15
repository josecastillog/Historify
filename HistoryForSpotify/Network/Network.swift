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
    
    var keys = Secret()
    var oauthswift: OAuth2Swift
    
    override init() {
        self.oauthswift = OAuth2Swift(
            consumerKey:    keys.consumerKey,
            consumerSecret: keys.consumerSecret,
            authorizeUrl: keys.authorizeUrl,
            accessTokenUrl: keys.accessTokenUrl,
            responseType: "code"
        )
    }
    
    @Published var isAuthorized = false
    
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
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getTopArtists() {
        oauthswift.client.get("https://api.spotify.com/v1/me/top/artists") { result in
            switch result {
            case .success(let response):
                let dataString = response.string
                print(dataString!)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
