//
//  GameEditorListView.swift
//  festival-mobile
//
//  Created by user188238 on 4/1/21.
//

import SwiftUI

struct GameEditorListView: View {
    
    @ObservedObject var gameEditorList: GameEditorListViewModel
    
    private(set) var editor: EditorViewModel
    
    var intent: GameEditorListIntent
    
    private var url: String
    
    init(editor: EditorViewModel, gameEditorList: GameEditorListViewModel){
        self.editor = editor
        self.gameEditorList = gameEditorList
        self.url = "https://festival-jeu.herokuapp.com/api/games/currentEditors/\(editor.id)"
        self.intent = GameEditorListIntent(gameEditorList: gameEditorList)
        let _ = self.gameEditorList.$gameEditorListState.sink(receiveValue: stateChanged)
        endOfInit()
    }
    
    func endOfInit() {
        self.intent.loadGames(url: url)
    }
    
    func stateChanged(state: GameEditorListState){
        switch state {
        case .new:
            intent.gamesLoaded()
        default:
            return
        }
    }
    
    var body: some View {
        VStack {
            Spacer().frame(height: 50)
            Text("Voici les jeux de l'éditeur : \(editor.name)")
            Spacer().frame(height: 50)
            List{
                ForEach(self.gameEditorList.games){
                    game in NavigationLink(
                        destination: GameDetails(game:game),
                        label: {
                            Text("\(game.name)")
                    })
                }
            }
        }.navigationTitle("\(editor.name)")
    }
}

