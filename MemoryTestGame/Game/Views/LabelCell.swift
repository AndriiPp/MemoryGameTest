//
//  LabelCell.swift
//  MemoryTestGame
//
//  Created by Andrii Pyvovarov on 11/24/19.
//  Copyright © 2019 Andrii Pyvovarov. All rights reserved.
//

import UIKit

class LabelCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet var cardImageView: UIImageView!
    
    //MARK: - create image
    func setImage(_ name: String) {
        let image : String = name.count > 0 ? "Card-\(name)" :  "Card-Bg";
        self.cardImageView.image = UIImage(named:image, in: Bundle(for: type(of: self)), compatibleWith: nil)
        
    }
}
