//
//  InfoDream.swift
//  DreaMY 1
//
//  Created by Sorrentino Pasquale on 02/12/2020.
//

import SwiftUI
import Foundation
import Speech

class InfoDreams : ObservableObject {
    @Published var listDreams = [Dream]() {
        willSet {
            let data = encode(info: newValue)
            UserDefaults.standard.set(data, forKey: "key")
        }
    }
    @Published var contfear = 0
    @Published var contangry = 0
    @Published var contsad = 0
    @Published var contlove = 0
    
    init() {
        //UserDefaults.standard.removeObject(forKey: "key") //per cancellare
        
        let data = UserDefaults.standard.data(forKey: "key")
        if let d = data {
            if let value = decode(data: d, type: [Dream].self){
                listDreams = value 
            }
        }
    }
    
    
    
    func add_dream(d : Dream){
        if d.emotion == "angry" {
            self.contangry = self.contangry + 1
        }
        else if d.emotion == "love" {
            contlove += 1
        }
        else if d.emotion == "sad" {
            contsad += 1
        }
        else {
            contfear += 1
        }
        listDreams.append(d)
    }
    func searchDream(word : String) -> [Dream]{
        var result = [Dream]()
        for dream in listDreams {
            if dream.testo.contains(word) {
                result.append(dream)
            }
        }
        return result
    }
}

func encode<T: Encodable>(info: T) -> Data? {
    return try? JSONEncoder().encode(info)
}
func decode<T: Decodable>(data: Data, type: T.Type) -> T? {
    return try? JSONDecoder().decode(type, from: data)
}

struct Dream : Codable {
    var title : String = ""
    var emotion : String = ""
    var date = "" //Date()
    var images = [String]()
    var testo : String = ""
}
