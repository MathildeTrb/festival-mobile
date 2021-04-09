//
//  GameTypeViewModel.swift
//  festival-mobile
//
//  Created by user188238 on 3/30/21.
//

import Foundation
import SwiftUI

class GameTypeViewModel : Identifiable {
    
    @ObservedObject var model : GameType
    
    var id : Int {
        return model.id
    }
    
    var label : String {
        return model.label
    }
    
    init(_ model : GameType) {
        self.model = model
    }
}
