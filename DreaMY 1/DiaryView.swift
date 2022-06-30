//
//  DiaryView.swift
//  DreaMY 1
//
//  Created by Sorrentino Pasquale on 02/12/2020.
//

import SwiftUI
import NaturalLanguage

struct DiaryView: View {
    @ObservedObject var listDream : InfoDreams
    @State var keySearch = ""
    @State var isSearching = false
    init(listDream : InfoDreams) {
        self.listDream = listDream
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        //UITableView.appearance().
    }
    var body: some View {
        ZStack{
            GeometryReader { geometry in
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    //.scaledToFill()
                    .edgesIgnoringSafeArea([.top,.bottom])
                    .frame(width: geometry.size.width)
            }
            VStack{
                    
                    List{
                        ForEach(listDream.listDreams, id:\.title){ dream in
                        HStack{
                            //Spacer()
                            ScrollView(.horizontal){
                                VStack(alignment: .center) {
                                    HStack{
                                        Color.clear
                                            .frame(width: 80, height: 50)
                                        Text(dream.title)
                                            .font(.title)
                                            .foregroundColor(.white)
                                            
                                        Image(dream.emotion)
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                    }
                                    Text(dream.testo)
                                        .font(.title3)
                                        .foregroundColor(.white)
                                    HStack{
                                        ForEach(dream.images, id:\.self){ i in
                                            Image(i)
                                                .resizable()
                                                .frame(width: 80, height: 80)
                                                    //.padding(5)
                                            }
                                    }
                                    Text(dream.date)
                                        .font(.caption)
                                        .foregroundColor(.white)
                                        
                                }
                            }
                        }
                    }.listRowBackground(Color.clear)
                }
            }
        }
    
    }
    func retrieveTokens(from text: String, unit: NLTokenUnit = .word) -> [String] {
        let tokenizer = NLTokenizer(unit: unit)
        tokenizer.string = text
        
        var tokens = [String]()
        tokenizer.enumerateTokens(in: text.startIndex..<text.endIndex) { (tokenRange, _) -> Bool in
            tokens.append(String(text[tokenRange].lowercased()))
            return true
        }
        print(tokens)
        return tokens
    }
}

struct DiaryView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryView(listDream: InfoDreams())
    }
}


