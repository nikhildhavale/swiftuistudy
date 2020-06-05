//
//  MemoryGame.swift
//  Test
//
//  Created by Nikhil on 25/05/20.
//  Copyright © 2020 Nikhil. All rights reserved.
//

import Foundation
struct MemoryGame<CardContent:Equatable> {
    private(set) var cards:[Card]
    var indexOfOneAndOnyFaceUpCard:Int?
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
        
        if let chosenIndex = self.indexOf(of: card) , !cards[chosenIndex].isFaceUp , !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfOneAndOnyFaceUpCard
            {
                if cards[chosenIndex].content ==  cards[potentialMatchIndex].content
                {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                indexOfOneAndOnyFaceUpCard = nil
                
            }
            else
            {
                for index in cards.indices
                {
                    cards[index].isFaceUp = false
                }
                indexOfOneAndOnyFaceUpCard = chosenIndex
            }
            self.cards[chosenIndex].isFaceUp = true

        }
        
        print("card choosen \(card)")
    }
    func indexOf(of card:Card) -> Int? {
        // TODO: bogus!
        cards.firstIndex { $0.id == card.id }
    }
    struct Card :Identifiable{
        var id: Int
        var isFaceUp:Bool = false
        var isMatched:Bool = false
        var content:CardContent
    }
}
