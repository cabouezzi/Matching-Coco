//
//  Card Model.swift
//  Matching Coco
//
//  Created by Chaniel Ezzi on 3/30/19.
//  Copyright © 2019 Lil Coco™. All rights reserved.
//

import Foundation

class CardModel {
    
    func getCards() -> [Card] {
        
        var generatedCardsArray = [Card]()
        
        for _ in 1...8 {
            
            let randomNumber = arc4random_uniform(14) + 1
                print(randomNumber)
            
                let cardOne = Card()
                cardOne.imageName = "card\(randomNumber)"
            
                generatedCardsArray.append(cardOne)
            
                let cardTwo = Card()
                cardTwo.imageName = "card\(randomNumber)"
            
                generatedCardsArray.append(cardTwo)
                
        }
        
        
        
        for i in 0...generatedCardsArray.count-1 {
            
            let randomNumber = Int(arc4random_uniform(UInt32(generatedCardsArray.count)))
        
            let temporaryStorage = generatedCardsArray[i]
            generatedCardsArray[i] = generatedCardsArray[randomNumber]
            generatedCardsArray[randomNumber] = temporaryStorage
            
        }
        
        return generatedCardsArray
        
    }
    
}
