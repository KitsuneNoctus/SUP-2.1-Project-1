//
//  Collectable.swift
//  SuperSpaceMan3D
//
//  Created by Henry Calderon on 10/28/20.
//

import Foundation
import SceneKit

class Collectable{
    class func pyramidNode() -> SCNNode{
        // 1 Creating the SCNGeometry type
        let pyramid = SCNPyramid(width: 3.0, height: 6.0, length: 3.0)
        
        // 2 Create the node using the geometry type
        let pyramidNode = SCNNode(geometry: pyramid)
        pyramidNode.name = "pyramid"
        
        //3 Setting the node position
        let position = SCNVector3Make(30, 0, -40)
        pyramidNode.position = position
        
        return pyramidNode
    }
}
