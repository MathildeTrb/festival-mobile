//
//  DisplayFestivalViewModel.swift
//  festival_jeux
//
//  Created by etud on 23/03/2021.
//

import Foundation
import Combine
import SwiftUI

enum DisplayFestivalState : CustomStringConvertible{
    case ready
    case loading(String)
    case loaded(Festival)
    case loadingError(Error)
    case new(Festival)

    var description: String{
        switch self {
        case .ready : return "ready"
        case .loading(let s) : return "loading: \(s)"
        case .loaded(let festival) : return "loaded: \(festival.name)"
        case .loadingError(let error) : return "loadingError: Error loading -> \(error)"
        case .new(let festival) : return "I have my festival: \(festival)"
        }
    }
}

struct AsyncFestivalImage: View {
    
    @ObservedObject private var festival: FestivalViewModel
    
    init(_ festival: FestivalViewModel) {
        self.festival = festival
    }
    
    var body: some View {
        content.onAppear(perform: festival.load)
    }
    
    private var content: some View {
        if let image = festival.imageUI {
            return Image(uiImage: image)
        }
        else {
            return Image(uiImage: Festival.unknownImage)
        }
    }
}

class FestivalViewModel: ObservableObject{
    
    private(set) var model : Festival
    
    var id : Int {
        return model.id
    }
    
    var name : String {
        return model.name
    }
    
    var imageUrl : String? {
        return model.imageUrl
    }
    
    var areas : [AreaViewModel]{
        var res = [AreaViewModel]()
        for area in model.areas {
            res.append(AreaViewModel(area))
        }
        return res
    }
    
    var imageUI: UIImage?{
        didSet{
            self.image = AsyncFestivalImage(self)
        }
    }
    
    var description: String{
        if let description = model.description {
            return description
        }
        return "Bienvenue"
    }
    
    
    @Published var image: AsyncFestivalImage?
        
    @Published var displayFestivalState : DisplayFestivalState = .ready{
        didSet{
            switch self.displayFestivalState {
            case let .loaded(data):
                print(data)
                model.new(festival: data)
                load()
                displayFestivalState = .new(model)
            case .loadingError:
                print("error")
                // faire un truc
            default:
                return
            }
        }
    }
    
    init(_ festival : Festival) {
        self.model = festival
    }
    
    private func imageLoaded(result: Result<UIImage, HttpRequestError>) {
        switch result {
        case let .success(data):
            print("C UNE REUSSITE")
            self.imageUI = ImageHelper.resizeImage(image: data, targetSize: CGSize(width: 400.0, height: 400.0))
        case let .failure(error):
            print(error)
            self.imageUI = Festival.unknownImage
        }
    }
    
    func load() -> Void {
        guard let url = self.imageUrl else {
            self.imageUI = Festival.unknownImage
            return
        }
        print("JE SUIS TON URL")
        print(url)
        HttpRequest.httpGetObject(from: url, initFromData: { (data: Data) -> UIImage? in return UIImage(data: data)}, endofrequest: imageLoaded)
    }
    
}
