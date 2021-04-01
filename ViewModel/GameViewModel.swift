//
//  GameViewModel.swift
//  festival-mobile
//
//  Created by user188238 on 3/30/21.
//

import Foundation
import SwiftUI

struct AsyncImage: View {
    
    private var game: GameViewModel
    
    init(_ game: GameViewModel) {
        self.game = game
    }
    
    var body: some View {
        content.onAppear(perform: game.load)
    }
    
    private var content: some View {
        if let image = game.imageUI {
            return Image(uiImage: image)
        }
        else {
            return Image(uiImage: Game.unknownImage)
        }
    }
}

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
    
    var imageUI: UIImage? {
        didSet {
            self.image = AsyncImage(self)
        }
    }
    
    var image: AsyncImage?

    init(_ model: Game) {
        self.model = model
        load()
    }
    
    private func imageLoaded(result: Result<UIImage, HttpRequestError>) {
        switch result {
        case let .success(data):
            self.imageUI = ImageHelper.resizeImage(image: data, targetSize: CGSize(width: 300.0, height: 300.0))
        case .failure(_):
            self.imageUI = Game.unknownImage
        }
    }
    
    func load() -> Void {
        guard let url = self.imageUrl else {
            self.imageUI = Game.unknownImage
            return
        }
        HttpRequest.httpGetObject(from: url, initFromData: { (data: Data) -> UIImage? in return UIImage(data: data)}, endofrequest: imageLoaded)
    }
    
}
