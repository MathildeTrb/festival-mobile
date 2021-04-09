//
//  EditorListIntent.swift
//  festival-mobile
//
//  Created by user188238 on 4/1/21.
//

import Foundation
import SwiftUI

class EditorListIntent {
    
    @ObservedObject var editorList: EditorListViewModel
    
    init(editorList: EditorListViewModel){
        self.editorList = editorList
    }
    
    func loadEditors(url: String){
        editorList.editorListState = .loading(url)
        HttpRequest.loadItemsFromAPI(url: url, endofrequest: httpJsonLoaded)
    }

    func editorsLoaded(){
        editorList.editorListState = .ready
    }
    
    func httpJsonLoaded(result: Result<[Editor], HttpRequestError>){
        
        switch result{
        case let .success(data):
            editorList.editorListState = .loaded(data)
        case let .failure(error):
            editorList.editorListState = .loadingError(error)
        }
        
    }
}
