//
//  TracksView.swift
//  HistoryForSpotify
//
//  Created by Jose Castillo on 12/15/22.
//

import SwiftUI

struct TracksView: View {
    
    @StateObject var network = Network.shared
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 12) {
//                ForEach(1..<20) { _ in
//                    TrackRowView()
//                }
                ForEach(Array(zip(network.tracks.indices, network.tracks)), id: \.0) { index, track in
                    VStack {
                        TrackRowView(trackNum: index, track: track)
                    }
                }
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 10)
        }
    }
}

struct TracksView_Previews: PreviewProvider {
    static var previews: some View {
        TracksView()
    }
}
