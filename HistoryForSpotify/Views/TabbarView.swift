//
//  TabbarView.swift
//  HistoryForSpotify
//
//  Created by Jose Castillo on 12/14/22.
//

import SwiftUI

struct TabbarView: View {
    var body: some View {
        TabView {
            ArtistView()
                .tabItem {
                    Label("Artists", systemImage: "person.fill")
                }
            TracksView()
                .tabItem {
                    Label("Tracks", systemImage: "music.note.list")
                }
            Text("Albums")
                .tabItem {
                    Label("Albums", systemImage: "opticaldisc")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
}

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView()
    }
}
