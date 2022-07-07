//
//  ContentView.swift
//  SwiftUIWithCombine
//
//  Created by Артур Дохно on 07.07.2022.
//

import SwiftUI
import Combine

class SlotViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
    private let emojiSourceArray = ["🍋", "🍒", "🍓"]
    private let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    init() {
        randomize()
        
        timer
            .receive(on: RunLoop.main)
            .sink { _ in self.randomize() }
            .store(in: &cancellables)
        
        $running
            .receive(on: RunLoop.main)
            .map { $0 == true ? "Stop" : "Play" }
            .assign(to: \.buttonText, on: self)
            .store(in: &cancellables)
    }
    
    func randomize() {
        guard running else { return }
        slot1Emoji = emojiSourceArray[Int.random(in: 0...emojiSourceArray.count - 1)]
        slot2Emoji = emojiSourceArray[Int.random(in: 0...emojiSourceArray.count - 1)]
        slot3Emoji = emojiSourceArray[Int.random(in: 0...emojiSourceArray.count - 1)]
    }
    
    @Published var running = false
    @Published var gameStarted = false
    
    @Published var slot1Emoji = "🍒"
    @Published var slot2Emoji = "🍓"
    @Published var slot3Emoji = "🍋"
    
    @Published var titleText = "Spin the drum"
    @Published var buttonText = ""
}

struct SlotView <Content: View>: View {
    var content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) { self.content = content }
    
    var body: some View {
            content()
            .font(.system(size: 64.0))
            .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom)))
            .animation(.easeInOut)
            .id(UUID())
    }
}

struct ContentView: View {
    @ObservedObject private var slotViewModel = SlotViewModel()
    
    var body: some View {

        VStack {
            Text("Casino 777")
            Spacer()
            Text(slotViewModel.titleText)
            Spacer()
            HStack {
                SlotView { Text(slotViewModel.slot1Emoji) }
                SlotView { Text(slotViewModel.slot2Emoji) }
                SlotView { Text(slotViewModel.slot3Emoji) }
            }
            Spacer()
            Button(action: { slotViewModel.running.toggle() }, label: { Text(slotViewModel.buttonText) })
            Spacer()
        }
        .onAppear { slotViewModel.gameStarted = true }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
