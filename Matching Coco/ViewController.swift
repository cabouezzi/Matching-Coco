//
//  ViewController.swift
//  Matching Coco
//
//  Created by Chaniel Ezzi on 3/30/19.
//  Copyright © 2019 Lil Coco™. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    @IBOutlet weak var timerLabel: UILabel!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model = CardModel()
    var cardArray = [Card]()
    
    var firstFlippedCardIndex:IndexPath?
    
    var timer:Timer?
    var milliseconds:Float = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        cardArray = model.getCards()
        
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    override func viewDidAppear(_ animated: Bool) {
        SoundManager.playSound(.shuffle)
    }
    
    
    
    @objc func timerElapsed () {
        
        milliseconds += 1
        
        let seconds = String(format: "%.2f", milliseconds/1000)
        
        timerLabel.text = "Time: \(seconds)"
        
        print("Time: \(seconds)")
        
        if milliseconds <= 0 {
            
            timer?.invalidate()
            timerLabel.textColor = UIColor.red
            
            checkGameEnded()
            
        }
        
    }
    
    func backgroundtimerElapsed () {
        
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        
    }
    
    
    //MARK: UICollectionView Protocol Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cardArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        cell.SetCard(card)
        
        return cell
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if milliseconds <= 0 {
            return
        }
        
        
        
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false && card.isMatched == false {
            
            cell.flip()
            
            SoundManager.playSound(.flip)
            
            card.isFlipped = true
            
            if firstFlippedCardIndex == nil {
                
               firstFlippedCardIndex = indexPath
                
            } else {
                
                checkForMatches(indexPath)
                
            }
            
        }
        
    }
    
    
    
    func checkForMatches (_ secondFlippedCardIndex:IndexPath) {
        
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        if cardOne.imageName == cardTwo.imageName {
            
            SoundManager.playSound(.match)
            
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            checkGameEnded()
            
        } else {
            
            SoundManager.playSound(.nomatch)
            
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
        
        }
        
        if cardOneCell == nil {
            
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
            
        }
        
        firstFlippedCardIndex = nil
    }
    
    
    
    
    func checkGameEnded () {
        
        var isWon = true
        
        for card in cardArray {
            
            if card.isMatched == false {
                isWon = false
                break
            }
            
        }
        
        
        
        var title = ""
        var message = ""
        
        if isWon == true {
                timer?.invalidate()
            let seconds: Float = milliseconds/1000
            
            title = "Congratulations!"
            message = "You won! Your time was \(seconds)! Now share with your friends! ❤ -Lil Coco"
            
            if seconds < previousHighScore || previousHighScore == 0 {
                previousHighScore = milliseconds/1000
                defaults.set(previousHighScore, forKey: "High Score")
                previousHighScore = defaults.float(forKey: "High Score")
            }
            
            

            
            
        } else {
            
            if milliseconds > 1200 {
                return
            }
            
            title = "Game Over"
            message = "You took way too long bro... ❤ -Lil Coco"
            
        }
        
        showAlert(title, message)
    }
    
    
    func moveToMenu () {
        
        let move = self.storyboard?.instantiateViewController(withIdentifier: "MenuScene") as! goButton
        self.navigationController?.pushViewController(move, animated: true)
        
    }

    func showAlert (_ title:String, _ message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Menu", style: .default, handler: {(ACTION) -> Void in self.moveToMenu()})
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}

