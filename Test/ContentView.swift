//
//  ContentView.swift
//  Test
//
//  Created by Nikhil on 25/05/20.
//  Copyright © 2020 Nikhil. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel:EmojiMemoryGame
    var body: some View {
        HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.chooseCard(card: card)
                }
            }

        }.padding()
            .foregroundColor(.orange)
            .font(Font.largeTitle)
        
        
    }
}
struct CardView:View
{
    var card:MemoryGame<String>.Card
    var body: some View {
        ZStack {
            if card.isFaceUp
            {
                RoundedRectangle(cornerRadius: 10.0).stroke().stroke(lineWidth: 2)
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                Text(card.content)
            }
            else
            {
                 RoundedRectangle(cornerRadius: 10.0).fill(Color.orange)
            }
           
        }
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
