//
//  TracksView.swift
//  HistoryForSpotify
//
//  Created by Jose Castillo on 12/15/22.
//

import SwiftUI

struct TracksView: View {
    
    @StateObject var network = Network.shared
    @State private var selectedFilter: FilterViewModel = .weeks
    @Namespace var animation
    
    var body: some View {
        VStack(spacing: 0) {
            filterBar
                .padding(.top, 6)
            switch selectedFilter {
            case .weeks:
                TrackScrollView(tracks: self.network.tracksWeeks)
            case .months:
                TrackScrollView(tracks: self.network.tracksMonths)
            case .allTime:
                TrackScrollView(tracks: self.network.tracksAllTime)
            }
        }
    }
}

struct TracksView_Previews: PreviewProvider {
    static var previews: some View {
        TracksView()
    }
}

extension TracksView {
    
    var filterBar : some View {
        HStack {
            ForEach(FilterViewModel.allCases, id: \.rawValue) { item in
                VStack {
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == item ? .semibold : .regular)
                        .foregroundColor(selectedFilter == item ? Color("WhiteBlack") : .gray)
                    
                    if selectedFilter == item {
                        Capsule()
                            .foregroundColor(Color("CustomGreen"))
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    } else {
                        Capsule()
                            .foregroundColor(Color(.clear))
                            .frame(height: 3)
                    }
                }.onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectedFilter = item
                    }
                }
            }
        }
        .overlay(Divider().offset(x: 0, y: 16))
    }
    
}

struct TrackScrollView: View {
    
    let tracks: [Track]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 8) {
                ForEach(Array(zip(tracks.indices, tracks)), id: \.0) { index, track in
                    VStack {
                        TrackRowView(trackNum: index, track: track)
                    }
                }
            }
            .padding(.vertical, 15)
            .padding(.trailing, 6)
            .padding(.leading, 8)
        }
    }
}
