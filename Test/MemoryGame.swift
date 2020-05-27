//
//  MemoryGame.swift
//  Test
//
//  Created by Nikhil on 25/05/20.
//  Copyright © 2020 Nikhil. All rights reserved.
//

import Foundation
struct MemoryGame<CardContent> {
    var cards:[Card]
    init(numberOfPairOfCard:Int,cardContentFactory:(Int) -> CardContent) {
        cards = [Card]()
        for pairIndex in 0..<numberOfPairOfCard
        {
            let cardContent = cardContentFactory(pairIndex)
            cards.append(Card(id: pairIndex*2, content: cardContent))
            cards.append(Card(id: pairIndex*2 + 1, content: cardContent))
            
        }
    }
    mutating func choose(card:Card )  {
        
        if let chosenIndex = self.indexOf(of: card)
        {
            self.cards[chosenIndex].isFaceUp = !self.cards[chosenIndex].isFaceUp
        }
        
        print("card choosen \(card)")
    }
    func indexOf(of card:Card) -> Int? {
        // TODO: bogus!
        cards.firstIndex { $0.id == card.id }
    }
    struct Card :Identifiable{
        var id: Int
        var isFaceUp:Bool = true
        var isMatched:Bool = false
        var content:CardContent
    }
}
