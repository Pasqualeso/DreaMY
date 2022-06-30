//
//  ImageClass.swift
//  DreaMY 1
//
//  Created by Sorrentino Pasquale on 03/12/2020.
//

import SwiftUI


class ArchiveImage {
    var Images = [ImageClass]()
    init() {
        var i = ImageClass()
        i.names = [ "friend", "friends", "mate", "mates", "pal", "pals", "companion", "companions", "homie", "homies" ]
        Images.append(i)
        
        i.names = [ "car", "autos", "auto", "cars", "automobile", "automobiles", "ferrari" ]
        Images.append(i)
        
        i.names = [ "sea", "ocean", "beach", "wave", "waves", "island" ]
        Images.append(i)
        
        i.names = [ "mountain", "mountains", "hill", "hills", "summit", "peak" ]
        Images.append(i)
        
        i.names = [ "city", "town", "village" ]
        Images.append(i)
        
        i.names = [ "park" ]
        Images.append(i)
        
        i.names = [ "trees", "woods" ]
        Images.append(i)
        
        i.names = [ "restaurant", "pub", ]
        Images.append(i)
        
        i.names = [ "coffee shop", "bar" ]
        Images.append(i)
        
        i.names = [ "hospital" ]
        Images.append(i)
        
        i.names = [ "street", "streets" ]
        Images.append(i)
        
        i.names = [ "waiter", "waitress" ]
        Images.append(i)
        
        i.names = [ "police", "policeman", "policemen", "policewoman", "policewomen", "soldier", "soldiers", "army" ]
        Images.append(i)
        
        i.names = [ "musician", "singer", "singers", "musicians" ]
        Images.append(i)
        
        i.names = [ "teacher", "teachers", "professor", "professors" ]
        Images.append(i)
        
        i.names = [ "doctor", "doctors" ]
        Images.append(i)
         
        i.names = [ "baby", "babies", "child", "children", "newborn", "newborns" ]
        Images.append(i)
        
        i.names = [ "thief", "robbery", "thieves", "aggression" ]
        Images.append(i)
        
        i.names = [ "fruit", "basket", "fruits", "apple", "apples", "banana", "bananas", "orange", "oranges", "mandarin", "mandarins", "pineapple", "pineapples", "watermelon", "melon" ]
        Images.append(i)
        
        i.names = [ "ghost", "ghosts", "nightmare", "nightmares", "monster", "monsters", "horror", "spirits" ]
        Images.append(i)
        
        i.names = [ "alien", "aliens", "ufo", "ufos" ]
        Images.append(i)
        
        i.names = [ "void", "falling into the void", "fall in void" ]
        Images.append(i)
        
        i.names = [ "separation", "separations", "heartbroken", "breakup", "lover" ]
        Images.append(i)
        
        i.names = [ "party", "parties", "cake", "cakes", "festivity", "firework", "fireworks" ]
        Images.append(i)
        
        i.names = [ "airplane", "airport", "fly", "aereo" ]
        Images.append(i)
        
        i.names = [ "family", "families", "relations", "relatives", "relative" ]
        Images.append(i)
        
        i.names = [ "sister", "sisters", "sibling", "siblings", "cousin", "cousins" ]
        Images.append(i)
        
        i.names = [ "brother", "brothers", "cousin", "cousins" ]
        Images.append(i)
        
        i.names = [ "grandfather", "grandad", "grandpa", "grandaddy", "gramps"]
        Images.append(i)
        
        i.names = [ "grandmother", "grandma", "granny", "grandparent", "grandparents" ]
        Images.append(i)
        
        i.names = ["mother", "mum", "mummy" ]
        Images.append(i)
        
        i.names = ["father", "dad", "daddy"]
        Images.append(i)
        
        i.names = ["dark", "darkness", "shadow", "shadows", "obscurity"]
        Images.append(i)
        
        i.names = ["telephone", "mobile", "iPhone", "smartphone", "cellular", "phone"]
        Images.append(i)
        
        i.names = ["dog", "dogs", "puppy", "puppies"]
        Images.append(i)
        
        i.names = ["cat", "cats", "kitty", "kitties", "feline", "felines"]
        Images.append(i)
        
        i.names = ["snake", "snakes", "serpent", "serpents"]
        Images.append(i)
        
        i.names = ["gym", "fitness", "sport", "sports", "gymnastic"]
        Images.append(i)
        
        i.names = ["school", "college", "academy", "university", "classroom", "classemate", "classmates", "faculty"]
        Images.append(i)
       
    }
    
    func searchImage(word : String) -> Int {
        if let i = Images.firstIndex(where: {
             $0.names.contains(word)
        }){
            return i
        } else {
            return -1
        }
    }
}

struct ImageClass {
    var names = [String]()
}

