//
//  GameViewModel.swift
//  festival-mobile
//
//  Created by user188238 on 3/30/21.
//

import Foundation
import SwiftUI

class GameViewModel: Identifiable {
    
    @ObservedObject private(set) var model : Game
    
    var id : Int {
        return model.id
    }
    
    var name : String {
        return model.name
    }
    
    var minNumberPlayer : Int {
        return model.minNumberPlayer
    }
    
    var maxNumberPlayer : Int {
        return model.maxNumberPlayer
    }
    
    var minYearPlayer : Int {
        return model.minYearPlayer
    }
    
    var duration : Int {
        return model.duration
    }
    
    var isPrototype : Bool {
        return model.isPrototype
    }
    
    var manual : String? {
        return model.manual
    }
    
    var imageUrl : String? {
        return model.imageUrl
    }
    
    var type : GameTypeViewModel {
        return GameTypeViewModel(model.type)
    }
    
    var editor : EditorViewModel {
        return EditorViewModel(model.editor)
    }
    
    
    
    init(_ model: Game) {
        self.model = model
    }
    
}
