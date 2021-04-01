//
//  Festival.swift
//  festival_jeux
//
//  Created by etud on 23/03/2021.
//

import Foundation
import Combine
import SwiftUI

protocol FestivalDelegate {
    func newFestival()
    
}

class Festival: Decodable, ObservableObject {
    
    static let unknownImage : UIImage = UIImage(systemName: "questionmark.square.fill")!
    
    // id of the festival
    private(set) var id : Int
    // name of the festival
    private(set) var name : String
    // image url of the festival
    private(set) var imageUrl : String?
    // description of the festival
    private(set) var description : String?
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
        self.description = festival.description
    }
}
