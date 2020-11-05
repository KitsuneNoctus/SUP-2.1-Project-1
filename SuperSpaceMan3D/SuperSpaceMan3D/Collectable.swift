//
//  Collectable.swift
//  SuperSpaceMan3D
//
//  Created by Henry Calderon on 10/28/20.
//

import Foundation
import SceneKit

class Collectable{
    //MARK: Pyramid
    class func pyramidNode() -> SCNNode{
        // 1 Creating the SCNGeometry type
        let pyramid = SCNPyramid(width: 3.0, height: 6.0, length: 3.0)
        
        // 2 Create the node using the geometry type
        let pyramidNode = SCNNode(geometry: pyramid)
        pyramidNode.name = "pyramid"
        
        //3 Setting the node position
        let position = SCNVector3Make(0, 0, 200)
        pyramidNode.position = position
        
        // 4 Giving the node some color.
        pyramidNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        pyramidNode.geometry?.firstMaterial?.shininess = 1.0
        
        return pyramidNode
    }
    
    //MARK: Sphere
    class func sphereNode() -> SCNNode{
        // 1 Creating the SCNGeometry type
        let sphere = SCNSphere(radius: 6.0)
        
        // 2 Create the node using the geometry type
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.name = "sphere"
        
        //3 Setting the node position
        let position = SCNVector3Make(0, 6, -200)
        sphereNode.position = position
        
        // 4 Giving the node some color.
        sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        sphereNode.geometry?.firstMaterial?.shininess = 1.0
        
        sphereNode.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName:
        "earthDiffuse")
        sphereNode.geometry?.firstMaterial?.ambient.contents = #imageLiteral(resourceName:
        "earthAmbient")
        sphereNode.geometry?.firstMaterial?.specular.contents = #imageLiteral(resourceName:
        "earthSpecular")
        sphereNode.geometry?.firstMaterial?.normal.contents = #imageLiteral(resourceName:
        "earthNormal")
        sphereNode.geometry?.firstMaterial?.diffuse.mipFilter = SCNFilterMode.linear
        sphereNode.geometry?.firstMaterial?.shininess = 1.0
        
        return sphereNode
    }
    
    //MARK: Box
    class func boxNode() -> SCNNode{
        let box = SCNBox(width: 3, height: 3, length: 3, chamferRadius: 0)
        
        let boxNode = SCNNode(geometry: box)
        boxNode.name = "box"
        
        let position = SCNVector3Make(200, 3.0, 0)
        boxNode.position = position
        
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        boxNode.geometry?.firstMaterial?.shininess = 1.0
        
        var materials = [SCNMaterial]()
        let boxImage = "boxSide"
        for index in 1...6{
            let material = SCNMaterial()
            material.diffuse.contents = UIImage(named: boxImage + String(index))
            materials.append(material)
        }

        boxNode.geometry?.materials = materials
        
        return boxNode
    }
    
    //MARK: Tube
    class func tubeNode() -> SCNNode {
        let tube = SCNTube(innerRadius: 1, outerRadius: 1.5, height: 2)
        
        let tubeNode = SCNNode(geometry: tube)
        tubeNode.name = "tube"
        
        let position = SCNVector3Make(-200, 1.5, 0)
        tubeNode.position = position
        
        tubeNode.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
        tubeNode.geometry?.firstMaterial?.shininess = 9.0
        
        return tubeNode
    }
    
    //MARK: Cylinder
    class func cylinderNode() -> SCNNode{
        let cylinder = SCNCylinder(radius: 3, height: 8)
        
        let cylinderNode = SCNNode(geometry: cylinder)
        cylinderNode.name = "cylinder"
        
        let position = SCNVector3Make(300, 8, 300)
        cylinderNode.position = position
        
        cylinderNode.geometry?.firstMaterial?.diffuse.contents = UIColor.green
        cylinderNode.geometry?.firstMaterial?.shininess = 1.0
        
        return cylinderNode
    }
    
    //MARK: Torus
    class func torusNode() -> SCNNode{
        let torus = SCNTorus(ringRadius: 7, pipeRadius: 2)
        
        let torusNode = SCNNode(geometry: torus)
        torusNode.name = "torus"
        
        let position = SCNVector3Make(-300, 0, 300)
        torusNode.position = position
        
        torusNode.geometry?.firstMaterial?.diffuse.contents = UIColor.orange
        torusNode.geometry?.firstMaterial?.shininess = 1.0
        
        return torusNode
    }
}
