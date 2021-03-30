//
//  Festival.swift
//  festival_jeux
//
//  Created by etud on 23/03/2021.
//

import Foundation
import Combine

protocol FestivalDelegate {
    func newFestival()
    
}

class Festival: Decodable, ObservableObject {
    
    // id of the festival
    private(set) var id : Int
    // name of the festival
    private(set) var name : String
    // image url of the festival
    private(set) var imageUrl : String?
    // areas of the  festival
    private(set) var areas : [Area]
    
    init(id: Int, name: String, imageUrl: String, areas: [Area]) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.areas = areas
    }
    
    func new (festival: Festival) {
        self.id = festival.id
        self.name = festival.name
        self.imageUrl = festival.imageUrl
        self.areas = festival.areas
        
    }
}
