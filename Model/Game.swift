//
//  Game.swift
//  festival_jeu
//
//  Created by etud on 23/03/2021.
//

import Foundation
import SwiftUI
import Combine

class Game: Decodable, Identifiable, ObservableObject {
    
    static let unknownImage : UIImage = UIImage(systemName: "questionmark.square.fill")!
    
    // id of the game
    private(set) var id : Int
    // name of the game
    private(set) var name: String
    // minimum number player of the game
    private(set) var minNumberPlayer: Int
    // maximum number player of the game
    private(set) var maxNumberPlayer: Int
    // minimum year player of the game
    private(set) var minYearPlayer: Int
    // duration of the game
    private(set) var duration: Int
    // isPrototype
    private(set) var isPrototype: Bool
    // manual of the game
    private(set) var manual: String?
    // image url of the game
    private(set) var imageUrl: String?
    // type of the game
    private(set) var type: GameType
    // editor of the game
    private(set) var editor: Editor
    
    init(id: Int, name:String, minNumberPlayer: Int, maxNumberPlayer: Int, minYearPlayer: Int, duration: Int, isPrototype: Bool, manualGame: String, imageUrl: String, type: GameType, editor: Editor){
        self.id = id
        self.name = name
        self.maxNumberPlayer = maxNumberPlayer
        self.minNumberPlayer = minNumberPlayer
        self.minYearPlayer = minYearPlayer
        self.duration = duration
        self.isPrototype = isPrototype
        self.manual = manualGame
        self.imageUrl = imageUrl
        self.type = type
        self.editor = editor
    }
}
