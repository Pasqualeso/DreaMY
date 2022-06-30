//
//  ContentView.swift
//  DreaMY 1
//
//  Created by Sorrentino Pasquale on 02/12/2020.
//

import SwiftUI
import NaturalLanguage

struct AddSogno: View {
    @State private var title : String = ""
    @State var e = ""
    @State var visibleSave = false
    @ObservedObject var audio = AudioClass()
    //@ObservedObject var ArchiveDreams = InfoDreams()
    @ObservedObject var listDreams : InfoDreams
    
    @State var textWord = [String]()
    @State var images = [String]()
    let formatter = DateFormatter()
    let size : CGFloat = 100
    @State var allImages = ArchiveImage()
    @State var isGenerated = false
    init (listDreams: InfoDreams /*, isGenerated : Bool*/) {
        self.listDreams = listDreams
        audio.requestAuthorization()
        //self.isGenerated = isGenerated
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
                VStack{
                HStack{
                    Spacer()
                    
                    Button(action: {
                        var dream = Dream()
                        //if self.visibleSave {
                        dream.emotion=e
                        dream.title = title
                        dream.testo = audio.testo
                        formatter.dateFormat = "dd.MM.yyyy"
                        dream.date = formatter.string(from: Date())
                        dream.images = self.images
                        self.listDreams.add_dream(d: dream)
                        isGenerated = false
                        images = []
                        title = ""
                        e = ""
                        //}
                        
                    }, label: {
                        //if self.visibleSave {
                            Text("Done")
                                .font(.title3)
                                .foregroundColor(.white)
                        //}
                    }).padding(.trailing, 30)
                    
                    
                }.padding()

                Text("Hey! What is your dream about?")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    
                }//.padding(30)
                ScrollView(.vertical){
                    VStack(spacing: 10){
                    Text("Tell me!")
                        .bold()
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(10)
                        
                    Button(action: {
                        if audio.isEnabled {
                            audio.recordButtonTapped()
                        }
                        
                    }, label: {
                        if audio.isRunning {
                            Image(systemName: "mic.circle.fill")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width:80, height: 80)
                        } else {
                            Image(systemName: "mic.circle.fill")
                                .resizable()
                                .foregroundColor(.green)
                                .frame(width:80, height: 80)
                        }
                    }).padding()
                        Text(audio.testo)
                            .font(.title3)
                            .foregroundColor(.white)
                            .lineLimit(6)
                            .padding()
                    Text("Give your dream a title:")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                        .padding(-10)
                    
                    TextField("\t Insert title here:", text: $title)
                        .font(.title3)
                        .frame(width: 200, height: 30)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(30)
                        .padding(10)
                    Text("What did you felt when dreaming?")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                    HStack{
                        Button(action: {
                            self.e="fear"
                            }, label: {
                                Image("fear")
                        })
                            .padding()
                                
                        Button(action: {
                                self.e="sad"
                            }, label: {
                                Image("sad")
                        })
                            .padding()
                                
                        Button(action: {
                                self.e="angry"
                                }, label: {
                                    Image("angry")
                        })
                            .padding()
                                
                        Button(action: {
                            self.e="love"
                        }, label: {
                            Image("love")
                        })
                        .padding()
                            
                    }.padding(-20)
                    
                    Button(action: {
                        var i : Int
                        var textWord : [String]
                        textWord = retrieveTokens(from: audio.testo)
                        for word in textWord {
                            i = allImages.searchImage(word: word)
                            if i != -1 {
                                images.append(self.allImages.Images[i].names[0])
                            }
                            print(i)
                            if images.count != 0 {
                                isGenerated = true
                            }
                        }
                        
                    }, label: {
                        Text("Generate images ")
                            .font(.title3)
                            .foregroundColor(Color.black)
                            .frame(width: 200, height: 40)
                            .background(Color.white)
                            .cornerRadius(30)
                        
                    }).padding()
                    if isGenerated {
                        ScrollView(.horizontal){
                            HStack(alignment: .center){
                                ForEach(images, id:\.self){ i in
                                    Image(i)
                                        .resizable()
                                        .frame(minWidth: size, maxWidth: size, minHeight: size, maxHeight: size)
                                        .padding(5)
                                }
                            }.listRowBackground(Color.clear)
                        }
                    }
                    }
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



struct AddSogno_Preview: PreviewProvider {
    static var previews: some View {
        AddSogno(listDreams: InfoDreams() /*, isGenerated: false */)
    }
}
