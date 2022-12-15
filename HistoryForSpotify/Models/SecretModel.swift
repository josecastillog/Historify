//
//  SecretModel.swift
//  HistoryForSpotify
//
//  Created by Jose Castillo on 12/14/22.
//

import Foundation

struct Secret {
    
    let consumerKey: String
    let consumerSecret: String
    let authorizeUrl: String
    let accessTokenUrl: String
    
    init() {
        
        let keys = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Config", ofType: "plist")!)
        
        self.consumerKey = keys!["consumerKey"] as! String
        self.consumerSecret = keys!["consumerSecret"] as! String
        self.authorizeUrl = keys!["authorizeUrl"] as! String
        self.accessTokenUrl = keys!["accessTokenUrl"] as! String
        
    }
}
