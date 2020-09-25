//
//  GameScene.swift
//  Game of Life CSBuildWeek
//
//  Created by Stephanie Ballard on 9/21/20.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // MARK: - Properties -
    var stepButton: MSButtonNode!
    var populationLabel: SKLabelNode!
    var generationLabel: SKLabelNode!
    var playButton: MSButtonNode!
    var pauseButton: MSButtonNode!
    
    var gridNode: Grid!
    
    @objc func stepSimulation() {
        gridNode.evolve()
        
        populationLabel.text = String(gridNode.population)
        generationLabel.text = String(gridNode.generation)
    }
    
    override func didMove(to view: SKView) {
        stepButton = childNode(withName: "stepButton") as? MSButtonNode
        populationLabel = childNode(withName: "populationLabel") as? SKLabelNode
        generationLabel = childNode(withName: "generationLabel") as? SKLabelNode
        playButton = childNode(withName: "playButton") as? MSButtonNode
        pauseButton = childNode(withName: "pauseButton") as? MSButtonNode
        gridNode = childNode(withName: "gridNode") as? Grid
        
        stepButton.selectedHandler = {
            self.stepSimulation()
        }
        let delay = SKAction.wait(forDuration: 0.5)
        let callMethod = SKAction.perform(#selector(stepSimulation), onTarget: self)
        let stepSequence = SKAction.sequence([delay, callMethod])
        let simulation = SKAction.repeatForever(stepSequence)
        self.run(simulation)
        self.isPaused = true
        
        playButton.selectedHandler = { [unowned self] in
            self.isPaused = false
        }
        pauseButton.selectedHandler = { [unowned self] in
            self.isPaused = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
