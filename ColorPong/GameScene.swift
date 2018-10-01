//
//  GameScene.swift
//  ColorPong
//
//  Created by SSIT on 29.08.18.
//  Copyright © 2018 ServetDavid. All rights reserved.
//

import SpriteKit
import GameplayKit

extension UIColor {
    var name: String? {
        switch self {
        case UIColor.white: return "White"
        case UIColor.red: return "Red"
        case UIColor.green: return "Green"
        case UIColor.blue: return "Blue"
        case UIColor.cyan: return "Cyan"
        case UIColor.brown: return "Brown"
        default: return nil
        }
    }
}

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var lmittig = false
    var rmittig = false
    var currentBallColor = "White"
    var currentCPColor = "White"
    
    var Checkpoint1 = SKSpriteNode()
    var Checkpoint2 = SKSpriteNode()
    
    var Colors: [String] = ["Blue","Green", /*"Red",*/ "White"/*, "Brown", "Cyan"*/]
    
    var counter = 0
    
    var scoreLabel = SKLabelNode()
    var scoreInt = 0
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        let center = size.width/2.0
        let difference = CGFloat(70.0)
        
        
        
        scoreLabel = self.childNode(withName: "Score") as! SKLabelNode
        ball.position.x = 335
        ball.position.y = -262.07
        let colorize = SKAction.colorize(with: changeBallColor(), colorBlendFactor: 1, duration: 0)
        ball.run(colorize)
        Checkpoint1 = self.childNode(withName: "Checkpoint1") as! SKSpriteNode
        Checkpoint2 = self.childNode(withName: "Checkpoint2") as! SKSpriteNode
        Checkpoint1.color = .green
        Checkpoint2.color = .blue
        
        ball.constraints = [SKConstraint.positionX(SKRange(constantValue: center - difference)), SKConstraint.positionX(SKRange(constantValue: center)), SKConstraint.positionX(SKRange(constantValue: center + difference))]
        
    }
    
    
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        //ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        
        border.restitution = 1
        border.friction = 0
        
        self.physicsBody = border
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        counter = counter + 1
        if(counter == 100){
            Checkpoint1.color = changeCPColor()
            Checkpoint2.color = changeCPColor()
            counter = 0
        }
        
        // Called before each frame is rendered
        if(ball.position.x < 0 && ball.position.x > -100){
            lmittig = true
        }else if(ball.position.x > 0 && ball.position.x < 100){
            rmittig = true
        }
        
        if(rmittig){
            if(currentBallColor == Checkpoint1.color.name){
                ball.position.x = -335
                ball.position.y = 94.047
                ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                rmittig = false
                scoreInt = scoreInt + 1
                scoreLabel.text = String(scoreInt)
                let colorize = SKAction.colorize(with: changeBallColor(), colorBlendFactor: 1, duration: 0)
                ball.run(colorize)
            }else{
                ball.position.x = 335
                ball.position.y = -262.07
                ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                rmittig = false
                scoreInt = 0
                scoreLabel.text = String(scoreInt)
                let colorize = SKAction.colorize(with: changeBallColor(), colorBlendFactor: 1, duration: 0)
                ball.run(colorize)
            }
        }
        
        if(lmittig){
            if(currentBallColor == Checkpoint2.color.name){
                ball.position.x = 335
                ball.position.y = 407.93
                ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                lmittig = false
                scoreInt = scoreInt + 1
                scoreLabel.text = String(scoreInt)
                let colorize = SKAction.colorize(with: changeBallColor(), colorBlendFactor: 1, duration: 0)
                ball.run(colorize)
            }else{
                ball.position.x = 335
                ball.position.y = -262.07
                ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                lmittig = false
                scoreInt = 0
                scoreLabel.text = String(scoreInt)
                let colorize = SKAction.colorize(with: changeBallColor(), colorBlendFactor: 1, duration: 0)
                ball.run(colorize)
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            if(location.x < 0){
                ball.physicsBody?.applyImpulse(CGVector(dx: -10, dy: 10))
            }else if(location.x > 0){
                ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
            }
            
        }
    }
    
    func changeBallColor() -> UIColor{
        let index = Int(arc4random_uniform(UInt32(Colors.count - 1)))
        
        
        switch Colors[index] {
        case "Blue":
            currentBallColor = "Blue"
            return .blue
        /*case "Brown":
            currentBallColor = "Brown"
            return .brown*/
        case "Green":
            currentBallColor = "Green"
            return .green
        /*case "Red":
            currentBallColor = "Red"
            return .red
        case "Cyan":
            currentBallColor = "Cyan"
            return .cyan*/
        default:
            return .white
        }
    }
    
    func changeCPColor() -> UIColor{
        let index = Int(arc4random_uniform(UInt32(Colors.count)))
        
        
        switch Colors[index] {
        case "Blue":
            currentCPColor = "Blue"
            return .blue
            /*case "Brown":
             currentCPColor = "Brown"
             return .brown*/
        case "Green":
            currentCPColor = "Green"
            return .green
            /*case "Red":
             currentCPColor = "Red"
             return .red
             case "Cyan":
             currentCPColor = "Cyan"
             return .cyan*/
        default:
            return .white
        }
    }
    
    
}
