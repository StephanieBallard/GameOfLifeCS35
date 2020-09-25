//
//  Grid.swift
//  Game of Life CSBuildWeek
//
//  Created by Stephanie Ballard on 9/22/20.
//

import SpriteKit

class Grid: SKSpriteNode {
    
    // MARK: - Properties -
    // Grid array dimensions
    let rows = 14
    let columns = 14
    
    // Cell dimensions
    var cellWidth = 0
    var cellHeight = 0
    
    // Counters
    var population = 0
    var generation = 0
    
    // Creature Array
    var gridArray = [[Creature]]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Enable own touch implementation for this node
        isUserInteractionEnabled = true
        
        // Calculate individual cell dimensions
        cellWidth = Int(size.width) / columns
        cellHeight = Int(size.height) / rows
        
        // Populate grid with creatures
        populateGrid()
    }
    
    // MARK: - Methods -
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // There will only be one touch, multi touch is not enabled by default
        let touch = touches.first!
        let location = touch.location(in: self)
        
        let gridX = Int(location.x) / cellWidth
        let gridY = Int(location.y) / cellHeight
    
        let creature = gridArray[gridX][gridY]
        creature.isAlive = !creature.isAlive
        print(gridX)
        print(gridY)
    }
    
    func addCreatureAtGrid(x: Int, y: Int) {
        let creature = Creature()
        let gridPosition = CGPoint(x: x * cellWidth, y: y * cellWidth)
        creature.position = gridPosition
        
        creature.isAlive = false
        
        addChild(creature)
        
        gridArray[x].append(creature)
    }
    
    func populateGrid() {
        for gridX in 0..<columns {
            gridArray.append([])
            for gridY in 0..<rows {
                addCreatureAtGrid(x: gridX, y: gridY)
            }
        }
    }
    
    func countNeighbors() {
        for gridX in 0..<columns {
            for gridY in 0..<rows {
                let currentCreature = gridArray[gridX][gridY]
                currentCreature.neighborCount = 0
                
                /* Loop through all adjacent creatures to current creature */
                for innerGridX in (gridX - 1)...(gridX + 1) {
                    if innerGridX<0 || innerGridX >= columns { continue }
                    
                    for innerGridY in (gridY - 1)...(gridY + 1) {
                        if innerGridY<0 || innerGridY >= rows { continue }
                        if innerGridX == gridX && innerGridY == gridY { continue }
                        
                        let adjacentCreature:Creature = gridArray[innerGridX][innerGridY]
                        
                        if adjacentCreature.isAlive {
                            currentCreature.neighborCount += 1
                        }
                        
                    }
                    
                    
                }
                
            }
            
        }
    }
    
    func updateCreatures() {
        population = 0
        
        for gridX in 0..<columns {
            for gridY in 0..<rows {
                let currentCreature = gridArray[gridX][gridY]
                
                switch currentCreature.neighborCount {
                case 3:
                    currentCreature.isAlive = true
                case 0...1, 4...8:
                    currentCreature.isAlive = false
                    break
                default:
                    break
                }
                if currentCreature.isAlive {
                    population += 1
                }
            }
        }
    }
    
    func evolve() {
        countNeighbors()
        updateCreatures()
        generation += 1
    }
}
