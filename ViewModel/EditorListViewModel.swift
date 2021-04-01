//
//  EditorViewModel.swift
//  festival-mobile
//
//  Created by user188238 on 3/30/21.
//

import Foundation

enum EditorListState: CustomStringConvertible{
    case ready
    case loading(String)
    case loaded([Editor])
    case loadingError(Error)
    case new([EditorViewModel])


    var description: String{
        switch self {
        case .ready : return "ready"
        case .loading(let s) : return "loading: \(s)"
        case .loaded(let editors) : return "loaded: \(editors.count) games"
        case .loadingError(let error) : return "loadingError: Error loading -> \(error)"
        case .new(let editors) : return "I have my editors: \(editors.count)"
        }
    }
}
class EditorListViewModel: ObservableObject {
    
    @Published private(set) var editors = [EditorViewModel]()
    
    @Published var editorListState: EditorListState = .ready{
        didSet {
            switch editorListState{
            case let .loaded(data):
         
                for editor in data{
                    self.editors.append(EditorViewModel(editor))
                }
                self.editorListState = .new(self.editors)
            case .loadingError:
                print("error")
            default: return
            }
        }
    }
}

