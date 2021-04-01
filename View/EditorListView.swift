//
//  EditorListView.swift
//  festival-mobile
//
//  Created by user188238 on 3/30/21.
//

import SwiftUI

struct EditorListView: View {
    
    @ObservedObject var editorList: EditorListViewModel

    var intent : EditorListIntent
       
    @State var textSearch: String = ""
    
    private var url: String = "https://festival-jeu.herokuapp.com/api/games/currentEditor"
    
    init(editorList: EditorListViewModel){
        self.editorList = editorList
        self.intent = EditorListIntent(editorList: editorList)
        let _ = editorList.$editorListState.sink(receiveValue: stateChanged)
        endOfinit()
    }
    
    func endOfinit(){
        self.intent.loadEditors(url: url)
    }
    
    func stateChanged(state: EditorListState){
        switch state{
        case let .loading(url):
            print("is loading url : \(url)")
        case .new:
            print("editors data arrived")
        default:
            return
        }
    }
    
    private func filterSearch(editor: EditorViewModel) -> Bool {
        var res: Bool = true
        
        if !textSearch.isEmpty {
            res = editor.name.contains(textSearch)
        }
        
        return res
    }
   

    var body: some View {
        return NavigationView{
        VStack {
                Spacer().frame(height:50)
                Text("Liste des éditeurs du festival")
                Spacer().frame(height:50)
                TextField("Recherche d'un éditeur", text:
                            $textSearch).font(.footnote).padding(10).background(Color.white)
                Spacer().frame(height: 50)
            ZStack{
                List{
                    ForEach(self.editorList.editors.filter(filterSearch)){
                        editor in
                        NavigationLink(
                            destination: GameEditorListView(editor: editor, gameEditorList: GameEditorListViewModel()),
                            label:{
                                Text("\(editor.name)")
                            }
                        )
                    }
                }
            }
        }
        }
    }
}
