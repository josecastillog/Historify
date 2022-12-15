//
//  AuthenticationViewController.swift
//  HistoryForSpotify
//
//  Created by Jose Castillo on 12/14/22.
//

import UIKit
import OAuthSwift

class AuthenticationViewController: UIViewController {
    
    let network = Network.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        network.oauthswift.authorizeURLHandler = SafariURLHandler(viewController: self, oauthSwift: network.oauthswift)
        network.authorize()
    }
    
}
