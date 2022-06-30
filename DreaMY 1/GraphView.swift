//
//  GraphView.swift
//  DreaMY 1
//
//  Created by Sorrentino Pasquale on 02/12/2020.
//

import SwiftUI

struct GraphView: View {
    @ObservedObject var listDreams : InfoDreams
    @State var progresAngry : Float = 0
    @State var progresSad : Float = 0
    @State var progresLove : Float = 0
    @State var progresFear : Float = 0
    /*
    init(listDreams : InfoDreams){
        self.listDreams = listDreams
        if(listDreams.listDreams.count != 0){
            self.progresAngry = Float( Float(self.listDreams.contangry) / Float(self.listDreams.listDreams.count) )
            self.progresLove = Float(self.listDreams.contlove/self.listDreams.listDreams.count)
            self.progresSad = Float(self.listDreams.contsad/self.listDreams.listDreams.count)
            self.progresFear = Float(self.listDreams.contfear/self.listDreams.listDreams.count)
        }
    }
 */
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack{
                Text("Stats of your dreams:")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                Text("Angry: \(listDreams.contangry)")
                    .foregroundColor(.white)
                Text("Love: \(listDreams.contlove)")
                    .foregroundColor(.white)
                Text("Fear: \(listDreams.contfear)")
                    .foregroundColor(.white)
                Text("Sad: \(listDreams.contsad)")
                    .foregroundColor(.white)
                Text("Total of dreams: \(self.listDreams.listDreams.count)")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                HStack{
                    ProgressBar(progress: self.$progresAngry, colore: Color.red, emoji: "angry")
                        .frame(width: 180, height: 180)
                        
                    ProgressBar(progress: self.$progresLove, colore: Color.pink, emoji: "love")
                        .frame(width: 180, height: 180)
                }.padding(20)
                HStack{
                    ProgressBar(progress: self.$progresFear, colore: Color.gray, emoji: "fear")
                        .frame(width: 180, height: 180)
                    ProgressBar(progress: self.$progresSad, colore: Color.blue, emoji: "sad")
                        .frame(width: 180, height: 180)
                }
                Button(action: {
                    self.progresAngry = Float( Float(self.listDreams.contangry) / Float(self.listDreams.listDreams.count) )
                    self.progresLove = Float( Float(self.listDreams.contlove)/Float(self.listDreams.listDreams.count))
                    self.progresSad = Float(Float(self.listDreams.contsad)/Float(self.listDreams.listDreams.count))
                    self.progresFear = Float(Float(self.listDreams.contfear)/Float(self.listDreams.listDreams.count))
                }, label: {
                    Text("Calculate percentage")
                        .font(.title3)
                        .bold()
                        .frame(width:240, height: 50)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(30)
                        .padding(30)
                })
            }
        }
        
    }
    
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView(listDreams: InfoDreams())
    }
}

struct ProgressBar: View {
    @Binding var progress: Float
    var colore: Color
    var emoji : String
    
    var body: some View {
        VStack{
            ZStack{
                //Cerchio "base" quello più opaco:
                
                Circle()
                    .stroke(lineWidth: 20) //grandezza del Cerchio
                    .opacity(0.3)
                    .foregroundColor(colore)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(self.progress,1.0)))
                    //Per indicare la grandezza e che la linea sia rotonda in entrambi gli estremi:
                    .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(colore)
                    .rotationEffect(Angle(degrees: 280))
                    .animation(.linear)
                
                Text(String(format: "%.0f %%",min(self.progress, 1.0)*100))
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                
                
            }
            Image(emoji)
        }
    }
}
