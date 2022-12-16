//
//  TrackRowView.swift
//  HistoryForSpotify
//
//  Created by Jose Castillo on 12/15/22.
//

import SwiftUI

struct TrackRowView: View {
    
    let trackNum: Int
    let track: Track
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            HStack(spacing: 12) {
                Text("\(trackNum+1).")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color("WhiteBlack"))
                    .frame(width: 55)
                HStack(spacing: 16) {
                    AsyncImage(
                        url: URL(string: track.album.images[2].url),
                        content: { image in
                            image.resizable()
                                 .aspectRatio(contentMode: .fill)
                                 .frame(width: 55, height: 55)
                                 .clipShape(RoundedRectangle(cornerRadius: 16))
                        },
                        placeholder: {
                            RoundedRectangle(cornerRadius: 18)
                                .frame(width: 55, height: 55)
                        }
                    )
                    VStack(alignment: .leading, spacing: 1) {
                        HStack(spacing: 6) {
                            Text(track.name)
                                .font(.headline).bold()
                                .foregroundColor(Color("WhiteBlack"))
                                .lineLimit(1)
//                                .fixedSize(horizontal: true, vertical: true)
                        }
                        Text(track.artists[0].name)
                            .font(.subheadline)
                            .foregroundColor(Color("WhiteBlack"))
                            .lineLimit(1)
//                            .fixedSize(horizontal: true, vertical: true)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 12)
                .padding(.horizontal, 15)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 25))
            }
        }
    }
}

//struct TrackRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrackRowView()
//    }
//}
