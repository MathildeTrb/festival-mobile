//
//  GameType.swift
//  festival_jeux
//
//  Created by etud on 23/03/2021.
//

import Foundation
import Combine

class GameType: Decodable, ObservableObject {
    
    //id of the type
    private(set) var id: Int
    // label of the type
    private(set) var label: String
    
    init(id: Int, label: String){
        self.id = id
        self.label = label
    }
    
}
