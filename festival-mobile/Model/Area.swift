//
//  Area.swift
//  festival_jeux
//
//  Created by etud on 23/03/2021.
//

import Foundation
import Combine
import SwiftUI

class Area: Decodable, Identifiable, ObservableObject {
    
    // id of the area
    private(set) var id : Int
    // label of the area
    private(set) var label : String
    // games of the area
    private(set) var games : [Game]
    
    init(id: Int, label: String, games: [Game]) {
        self.id = id
        self.label = label
        self.games = games
    }
}
