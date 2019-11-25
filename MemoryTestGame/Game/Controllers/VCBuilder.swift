//
//  VCBuilder.swift
//  MemoryTestGame
//
//  Created by Andrii Pyvovarov on 11/25/19.
//  Copyright © 2019 Andrii Pyvovarov. All rights reserved.
//

import UIKit

//MARK: - ViewController creator
class VSBuilder {
    class func createGameVC() -> UIViewController {
        let storyboard = UIStoryboard(name: "Game", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "GameVCStoryIdent")
        controller.modalPresentationStyle = .fullScreen
        return controller
    }
    class func createSecondGameVC() -> UIViewController {
        let storyboard = UIStoryboard(name: "SecondGame", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "GameVCStoryIdent")
        controller.modalPresentationStyle = .fullScreen
        return controller
    }
    class func createLevelVC() -> UIViewController {
        let storyboard = UIStoryboard(name: "levelStory", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "levelStoryboard")
        controller.modalPresentationStyle = .fullScreen
        return controller
    }
}
