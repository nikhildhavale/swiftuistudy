//
//  EmojiMemoryGame.swift
//  Test
//
//  Created by Nikhil on 25/05/20.
//  Copyright © 2020 Nikhil. All rights reserved.
//

import SwiftUI
class EmojiMemoryGame: ObservableObject
{
    @Published private(set) var dataModel:MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    static func createMemoryGame() -> MemoryGame<String>
    {
        let emojisArray =  ["👻","🎃","🕷"]
        return MemoryGame<String>(numberOfPairOfCard: emojisArray.count ) { pairIndex in
            return emojisArray[pairIndex]
        }
    }
    
    // MARK: - access to the model
    var cards:[MemoryGame<String>.Card]
    {
        dataModel.cards
    }
    // MARK: - Intent(x)
    func chooseCard(card:MemoryGame<String>.Card)
    {
        objectWillChange.send()
        dataModel.choose(card: card)
    }
}
