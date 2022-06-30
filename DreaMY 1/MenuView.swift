//
//  MenuView.swift
//  DreaMY 1
//
//  Created by Sorrentino Pasquale on 02/12/2020.
//

import SwiftUI

struct MenuView: View {
    @State var selection : Int = 0
    @ObservedObject var listDreams = InfoDreams()
    
 
    var body: some View {
        
            TabView(selection: $selection) {
                AddSogno(listDreams: listDreams)
                //Text("ciao")
                    .tabItem {
                        Text("Add")
                        Image(systemName: "moon.zzz")
                    }.tag(0)

                //DiaryView(ListDream: ListDreams)
                DiaryView(listDream: listDreams)
                    .tabItem {
                        Text("Diary")
                            Image(systemName: "book")
                }.tag(1)

                GraphView(listDreams: listDreams)
                    .tabItem {
                        Text("Stat")
                            Image(systemName: "chart.bar.xaxis")
                    }.tag(2)
                
            }
        }
    }


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
 
