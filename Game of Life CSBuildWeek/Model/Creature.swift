//
//  Creature.swift
//  Game of Life CSBuildWeek
//
//  Created by Stephanie Ballard on 9/22/20.
//

import SpriteKit

class Creature: SKSpriteNode {
    // MARK: - Properties -
    var isAlive: Bool = false {
        didSet {
            isHidden = !isAlive
        }
    }
    
    // Living neighbor counter
    var neighborCount = 0
    
    init() {
        // Initialize with black circle image
        let texture = SKTexture(imageNamed: "blackCircle")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        // Set Z position to make sure it's on top of the grid
        zPosition = 1
        
        // Set anchor point to bottom left
        anchorPoint = CGPoint(x: 0, y: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
