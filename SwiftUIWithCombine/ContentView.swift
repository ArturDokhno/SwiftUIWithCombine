//
//  ContentView.swift
//  SwiftUIWithCombine
//
//  Created by Артур Дохно on 07.07.2022.
//

import SwiftUI
import Combine

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Casino 777")
                .font(.system(size: 60))
                .foregroundColor(.yellow)
            Spacer()
            Text("Spin the drum")
            
            Spacer()
            HStack {
                Text("🍋").font(.largeTitle)
                Spacer().frame(width: 25)
                Text("🍓").font(.largeTitle)
                Spacer().frame(width: 25)
                Text("🍒").font(.largeTitle)
                Spacer().frame(width: 25)
            }
            
            Spacer()
            Button {
                
            } label: {
                Text("Play")
            }
            .buttonStyle(.borderedProminent)

            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
