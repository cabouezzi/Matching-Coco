//
//  CollectionViewCell.swift
//  Matching Coco
//
//  Created by Chaniel Ezzi on 3/30/19.
//  Copyright © 2019 Lil Coco™. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var FrontImageView: UIImageView!
    
    
    @IBOutlet weak var BackImageView: UIImageView!
    
    var card:Card?
    
    func SetCard(_ card:Card) {
        
        self.card = card
        
        if card.isMatched == true {
            
            BackImageView.alpha = 0
            FrontImageView.alpha = 0
            
            return
            
        } else {
            
            BackImageView.alpha = 1
            FrontImageView.alpha = 1
            
        }
        
        
        FrontImageView.image = UIImage(named: card.imageName)
        
        if card.isFlipped == true {
            
            UIView.transition(from: BackImageView, to: FrontImageView, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews] , completion: nil)
            
        } else {
            
            UIView.transition(from: FrontImageView, to: BackImageView, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews] , completion: nil)
            
        }
        
    }
    
    func flip () {
        
        UIView.transition(from: BackImageView, to: FrontImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        
    }
    
    func flipBack () {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4) {
            
            UIView.transition(from: self.FrontImageView, to: self.BackImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
            
        }
        
    }
    
    func remove () {
            
            UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
                
                self.FrontImageView.alpha = 0
                
            }, completion: nil)
        
    }
    
}
