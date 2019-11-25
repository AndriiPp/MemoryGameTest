//
//  LevelViewController.swift
//  MemoryTestGame
//
//  Created by Andrii Pyvovarov on 11/25/19.
//  Copyright © 2019 Andrii Pyvovarov. All rights reserved.
//

import UIKit

class LevelViewController: UIViewController {
    //MARK: - IBOutlets and IBActions
    @IBOutlet weak var selectLevel: UILabel!
    @IBAction func level1(_ sender: Any) {
        loadGame()
    }
    @IBAction func level2(_ sender: Any) {
        secondLoadGame()
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        selectLevelSetup()
    }
    
    //MARK: - Private functions
    private func selectLevelSetup(){
        selectLevel.layer.borderColor = UIColor.black.cgColor
        selectLevel.layer.borderWidth = 1
        selectLevel.layer.cornerRadius = 7
    }
    private func loadGame(){
        weak var gameVC = (VSBuilder.createGameVC() as! GameViewController)
        self.present(gameVC!, animated: true, completion: nil)
    }
    private func secondLoadGame(){
        weak var secondGameVC = (VSBuilder.createSecondGameVC() as! SecondGameViewController)
        self.present(secondGameVC!, animated: true, completion: nil)
    }
}
