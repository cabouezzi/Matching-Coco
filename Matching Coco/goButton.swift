//
//  goButton.swift
//  Matching Coco
//
//  Created by Chaniel Ezzi on 3/31/19.
//  Copyright © 2019 Lil Coco™. All rights reserved.
//

import Foundation
import UIKit
var previousHighScore: Float = 0
let defaults = UserDefaults.standard

class goButton: UIViewController {
    
    
    @IBOutlet weak var highscore: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        SoundManager.playSound(.goingBad)
        
        previousHighScore = defaults.float(forKey: "High Score")
        
        highscore.text = "Fastest Time: \(previousHighScore) seconds"
        
        if previousHighScore == 0 {
            highscore.text = "Fastest Time: Not Set"
        }
        
    }
    
    
    func moveToGame () {
        
        let move = self.storyboard?.instantiateViewController(withIdentifier: "GameScene") as! UIViewController
        self.navigationController?.pushViewController(move, animated: true)
    }
    
    
    @IBAction func goToGameButton(_ sender: UIButton) {
        moveToGame()
    }
    
    
}
