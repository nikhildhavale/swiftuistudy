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
    @ViewBuilder
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle().fill(Color.orange).padding(5).opacity(0.4)
                Text(self.card.content).font(Font.system(size: min(geometry.size.width, geometry.size.height) * 0.65))
               
            }.cardify(isFaceUp: self.card.isFaceUp, isMatched: self.card.isMatched)
                
        }
        
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.chooseCard(card: game.cards[0])
        return ContentView(viewModel: game)
    }
}
struct Cardify:ViewModifier
{
    var isFaceUp:Bool
    var isMatched:Bool
    func body(content: Content) -> some View {
        ZStack {
            
            if isFaceUp || isMatched
            {
                RoundedRectangle(cornerRadius: 10.0).stroke().stroke(lineWidth: 2)
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                content
            }
            else
            {
                RoundedRectangle(cornerRadius: 10.0)                .fill(Color.orange)
                
            }
            
        }
        
    }
}
    

extension View
{
    func cardify(isFaceUp:Bool,isMatched:Bool) -> some View
    {
       modifier(Cardify(isFaceUp: isFaceUp, isMatched: isMatched))
    }
}
