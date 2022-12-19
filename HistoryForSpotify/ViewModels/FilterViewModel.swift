//
//  FilterViewModel.swift
//  HistoryForSpotify
//
//  Created by Jose Castillo on 12/16/22.
//

import Foundation

enum FilterViewModel: Int, CaseIterable {
    case weeks
    case months
    case allTime
    
    var title: String {
        switch self {
        case .weeks: return "4 Weeks"
        case .months: return "6 Months"
        case .allTime: return "All Time"
        }
    }
}
