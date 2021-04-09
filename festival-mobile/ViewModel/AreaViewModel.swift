//
//  AreaViewModel.swift
//  festival-mobile
//
//  Created by user188238 on 3/30/21.
//

import Foundation
import SwiftUI

class AreaViewModel: Identifiable {
    
    @ObservedObject private(set) var model : Area
    
    var id : Int {
        return model.id
    }
    
    var label : String {
        return model.label
    }
    
    var games : [GameViewModel] {
        var res = [GameViewModel]()
        for game in model.games {
            res.append(GameViewModel(game))
        }
        return res
    }
    
    
    init(_ model: Area) {
        self.model = model
    }
    
}
