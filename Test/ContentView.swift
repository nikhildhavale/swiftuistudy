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
        VStack
            {
                Grid(viewModel.cards)  { card in
                    CardView(card: card).onTapGesture {
                        withAnimation(.easeInOut){
                            self.viewModel.chooseCard(card: card)

                        }
                        }.padding(5)
                }
                Button(action: {
                    withAnimation(.easeInOut){
                        self.viewModel.resetGame()

                    }
                }, label: {
                    Text("New Game")
                })
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
//    private func body(for size:CGSize) -> some View
//    {
//
//    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.chooseCard(card: game.cards[0])
        return ContentView(viewModel: game)
    }
}
struct Cardify:AnimatableModifier
{
    var rotation:Double
    init(isFaceUp:Bool,isMatched:Bool) {
        rotation = isFaceUp ? 180 : 0
        self.isMatched = isMatched
    }
    var isFaceUp:Bool
    {
        rotation > 90
    }
    var animatableData: Double
    {
        get{ rotation}
        set{rotation = newValue}
    }
    var isMatched:Bool
    func body(content: Content) -> some View {
        ZStack {
            
            if isFaceUp || isMatched
            {
                RoundedRectangle(cornerRadius: 10.0).stroke().stroke(lineWidth: 2)
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                content/*.rotationEffect(Angle.degrees(isMatched ? 180 : 0  ) )*/
            }
            else
            {
                RoundedRectangle(cornerRadius: 10.0)        .fill(Color.orange)
                
            }
            
        }.rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
        .animation(Animation.linear(duration: 3))
        
    }
}
    

extension View
{
    func cardify(isFaceUp:Bool,isMatched:Bool) -> some View
    {
       modifier(Cardify(isFaceUp: isFaceUp, isMatched: isMatched))
    }
}
