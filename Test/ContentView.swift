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
//        HStack {
//            ForEach(viewModel.cards) { card in
//                CardView(card: card).onTapGesture {
//                    self.viewModel.chooseCard(card: card)
//                }
//            }
//
//        }.padding()
//            .foregroundColor(.orange)
//            .font(Font.largeTitle)
        Grid(viewModel.cards)  { card in
            CardView(card: card).onTapGesture {
                self.viewModel.chooseCard(card: card)
                }.padding(5)
        }
        
    }
}
struct CardView:View
{
    var card:MemoryGame<String>.Card
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                if self.card.isFaceUp || self.card.isMatched
                {
                    RoundedRectangle(cornerRadius: 10.0).stroke().stroke(lineWidth: 2)
                    RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                    Text(self.card.content)
                }
                else if !self.card.isMatched
                {
                     RoundedRectangle(cornerRadius: 10.0).fill(Color.orange)
                }
               
            }.font(Font.system(size: min(geometry.size.width, geometry.size.height) * 0.75) )
        }
        
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
