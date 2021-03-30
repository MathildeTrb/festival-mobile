//
//  Editor.swift
//  festival_jeux
//
//  Created by etud on 23/03/2021.
//

import Foundation
import Combine

class Editor: Decodable, ObservableObject {
    
    // id of the editor
    private(set) var id: Int
    // name of the editor
    private(set) var name: String
    
    init (id: Int, name: String){
        self.id = id
        self.name = name
    }
    
}
