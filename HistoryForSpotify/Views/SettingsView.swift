//
//  SettingsView.swift
//  HistoryForSpotify
//
//  Created by Jose Castillo on 12/19/22.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        Button {
            
        } label: {
            Text("Log Out")
                .foregroundColor(Color(.white))
                .frame(width: 200)
                .padding()
                .background(Color("CustomGray"))
                .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
