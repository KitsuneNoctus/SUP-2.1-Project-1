//
//  GameViewController.swift
//  SuperSpaceMan3D
//
//  Created by Henry Calderon on 10/28/20.
//

import UIKit
import QuartzCore
import SceneKit


class GameViewController: UIViewController {

    var mainScene: SCNScene!
    var spotLight: SCNNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create a new scene
        mainScene = createMainScene()
        let sceneView = self.view as! SCNView
        sceneView.scene = mainScene
        
        // Optional, but nice to be turned on during developement
        sceneView.showsStatistics = true
        sceneView.allowsCameraControl = true
        
    }
    
    //MARK: Create Main Scene
    func createMainScene() -> SCNScene {
        let mainScene = SCNScene(named: "art.scnassets/hero.dae")
        mainScene!.rootNode.addChildNode(createFloorNode())
        mainScene!.rootNode.addChildNode(Collectable.pyramidNode())
        mainScene!.rootNode.addChildNode(Collectable.sphereNode())
        mainScene!.rootNode.addChildNode(Collectable.boxNode())
        mainScene!.rootNode.addChildNode(Collectable.tubeNode())
        mainScene!.rootNode.addChildNode(Collectable.cylinderNode())
        mainScene!.rootNode.addChildNode(Collectable.torusNode())
        createHeroCamera()
        setupLighting(scene: mainScene!)
        return mainScene!
    }
    
    func createFloorNode() -> SCNNode{
        let floorNode = SCNNode()
        floorNode.geometry = SCNFloor()
        floorNode.geometry?.firstMaterial?.diffuse.contents = "Floor"
        
        return floorNode
    }
    
    //MARK: Camera
    func createHeroCamera(){
        //        You first initialize the cameraNode as a scene node (SCNNode()).
        //        After you have the node initialized, you initialize the camera parameter for the node.
        let cameraNode = mainScene.rootNode.childNode(withName: "mainCamera", recursively: true)
        //        For this camera, you will need to set the zFar parameter. The zFar parameter is the maximum distance between the camera and the visible surface.
        cameraNode?.camera?.zFar = 500
        //        The camera also needs a position; you’ll set this position to be slightly
        //        behind and above the spaceman to start with. Later in the game
        //        development you’ll adjust this position to follow the spaceman around
        //        the scene.
        cameraNode?.position = SCNVector3(50, 0, -20)
        //        You now need to set the rotation of the camera. Currently the camera is pointing straight ahead; however, because you put the camera slightly above your spaceman, you need to rotate it slightly down. This is exactly what setting the w: parameter in the SCNVector4 is doing.
        cameraNode?.rotation = SCNVector4(0, 0, 0, Float.pi/4 * 0.5)
        cameraNode?.eulerAngles = SCNVector3(x: -70, y: 0, z: 0) //Float(-M_PI_4*0.75))
        let heroNode = mainScene.rootNode.childNode(withName: "hero", recursively: true)
        heroNode?.addChildNode(cameraNode!)
        
        mainScene.rootNode.childNode(withName: "hero", recursively: true)?.addChildNode(cameraNode!)
    }
    
    //MARK: Lighting
    func setupLighting(scene: SCNScene){
        
        let ambientLight = SCNNode()
        ambientLight.light = SCNLight()
        ambientLight.light?.type = SCNLight.LightType.ambient
        ambientLight.light?.color = UIColor.white
        scene.rootNode.addChildNode(ambientLight)
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = SCNLight.LightType.spot
        lightNode.light?.castsShadow = true
        lightNode.light!.color = UIColor(white: 0.8, alpha: 1.0)
        lightNode.position = SCNVector3Make(0, 80, 30)
        lightNode.rotation = SCNVector4Make(1, 0, 0, Float(-M_PI/2.8))
        lightNode.light?.spotInnerAngle = 0
        lightNode.light?.spotOuterAngle = 50
        lightNode.light?.shadowColor = UIColor.black
        lightNode.light?.zFar = 500
        lightNode.light?.zNear = 50
        scene.rootNode.addChildNode(lightNode)
    }
    

}
