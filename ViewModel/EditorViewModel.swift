//
//  EditorViewModel.swift
//  festival-mobile
//
//  Created by user188238 on 3/31/21.
//

import SwiftUI

class EditorViewModel: Identifiable {
    
    @ObservedObject private(set) var model : Editor
    
    var id: Int {
        return model.id
    }
    
    var name: String {
        return model.name
    }
    
    init(_ model: Editor){
        self.model = model
    }
}
