//
//  ContentView.swift
//  HistoryForSpotify
//
//  Created by Jose Castillo on 12/9/22.
//

import SwiftUI
import UIKit
import OAuthSwift

struct ContentView: View {
    
    @StateObject var network = Network.shared
    
    var body: some View {
        NavigationView {
            if(network.isAuthorized) {
                TabbarView()
            } else {
                AuthViewContainer()
            }
        }
        .onOpenURL {url in
            OAuthSwift.handle(url: url)
        }
    }
    
}

struct AuthViewContainer : UIViewControllerRepresentable {
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<AuthViewContainer>) -> AuthenticationViewController {
        
        let viewController = AuthenticationViewController()
        return viewController
        
    }
    
    func updateUIViewController(_ uiView: AuthenticationViewController, context: UIViewControllerRepresentableContext<AuthViewContainer>) {
        
    }
    
}
