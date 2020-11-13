//
//  GameOverView.swift
//  SuperSpaceMan3D
//
//  Created by Henry Calderon on 11/12/20.
//

import Foundation
import SpriteKit
class GameOverView: SKScene {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init(size: CGSize, score: String) {
        super.init(size: size)
        backgroundColor = .red
        let backgroundNode = SKSpriteNode(imageNamed: "GameOverBackground")
        backgroundNode.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        backgroundNode.position = CGPoint(x: 160.0, y: 0.0)
        addChild(backgroundNode)
        let scoreTextNode = SKLabelNode(fontNamed: "Copperplate")
        scoreTextNode.text = "SCORE : \(score)"
        scoreTextNode.horizontalAlignmentMode = .center
        scoreTextNode.verticalAlignmentMode = .center
        scoreTextNode.fontSize = 20
        scoreTextNode.fontColor = .white
        scoreTextNode.position = CGPoint(x: size.width / 2.0, y: size.height - 75.0)
        addChild(scoreTextNode)
        let tryAgainText = SKLabelNode(fontNamed: "Copperplate")
        tryAgainText.text = "TAP ANYWHERE TO PLAY AGAIN!"
        tryAgainText.horizontalAlignmentMode = .center
        tryAgainText.verticalAlignmentMode = .center
        tryAgainText.fontSize = 20
        tryAgainText.fontColor = .white
        tryAgainText.position = CGPoint(x: size.width / 2.0, y: size.height - 200)
        addChild(tryAgainText)
    }
}
