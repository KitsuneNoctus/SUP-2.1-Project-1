//
//  GameViewController.swift
//  SuperSpaceMan3D
//
//  Created by Henry Calderon on 10/28/20.
//

import UIKit
import QuartzCore
import SceneKit
import CoreMotion


class GameViewController: UIViewController {

    var mainScene: SCNScene!
    var spotLight: SCNNode!
    
    var touchCount: Int?
    
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create a new scene
        mainScene = createMainScene()
        
        createMainCamera()
        createHeroCamera(mainScene: mainScene)
        
        let sceneView = self.view as! SCNView
        sceneView.scene = mainScene
        sceneView.delegate = self
        
        // Optional, but nice to be turned on during developement
        sceneView.showsStatistics = true
        sceneView.allowsCameraControl = true
        
        setupAccelerometer()
        
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
//        createHeroCamera()
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
    ///The stuff below is what came first
//    func createHeroCamera(mainScene:SCNScene) {
//        let cameraNode = mainScene.rootNode.childNode(withName: "mainCamera", recursively: true)
//        cameraNode?.camera?.zFar = 500
//        cameraNode?.position = SCNVector3(x: 50, y: 0, z: -20)
//        cameraNode?.rotation = SCNVector4(x: 0, y: 0, z: 0, w: Float.pi/4 * 0.5)
//        cameraNode?.eulerAngles = SCNVector3(x: -70, y: 0, z: 0) //Float(-M_PI_4*0.75))
//        let heroNode = mainScene.rootNode.childNode(withName: "hero", recursively: true)
//        heroNode?.addChildNode(cameraNode!)
//        mainScene.rootNode.childNode(withName: "hero", recursively: true)?.addChildNode(cameraNode!)
//    }
    
    ///This is what was taken from github created for this book.
    func createHeroCamera(mainScene:SCNScene) {
        
        let cameraNode = mainScene.rootNode.childNode(withName: "mainCamera", recursively: true)
        
        cameraNode?.camera?.zFar = 500
        cameraNode?.position = SCNVector3(x: 50, y: 0, z: -20)
        
//        cameraNode?.camera?.usesOrthographicProjection = true
//        cameraNode?.camera?.orthographicScale = 100
        cameraNode?.eulerAngles = SCNVector3(x: 0, y: 90, z: 0) //Float(-M_PI_4*0.75))
        
        let heroNode = mainScene.rootNode.childNode(withName: "hero", recursively: true)
        heroNode?.addChildNode(cameraNode!)

//        mainScene.rootNode.childNode(withName: "hero", recursively: true)?.addChildNode(cameraNode!)
    }
    
    //From the repository
//    func createHeroCamera() {
//
//        let cameraNode = mainScene.rootNode.childNode(withName: "mainCamera", recursively: true)
//
//        cameraNode?.camera?.zFar = 1000
//        cameraNode?.position = SCNVector3(x: 0, y: 0, z: -100)
//
////        cameraNode?.camera?.usesOrthographicProjection = true
////        cameraNode?.camera?.orthographicScale = 100
//        cameraNode?.eulerAngles = SCNVector3(x: 0, y: 90, z: 0) //Float(-M_PI_4*0.75))
//
//        let heroNode = mainScene.rootNode.childNode(withName: "hero", recursively: true)
//        heroNode?.addChildNode(cameraNode!)
//
//        mainScene.rootNode.childNode(withName: "hero", recursively: true)?.addChildNode(cameraNode!)
//    }
    
    func positionCameraWithSpaceman(){
        //You get the hero node using the presentationNode() method so you can get his current position.
        let heroNode = mainScene.rootNode.childNode(withName: "hero", recursively: true)?.presentation
        let spacemanPosition = heroNode?.position
        let cameraDamping: Float = 0.3
        //Next, using a little math and the SCNVector3 initializer, you position the camera above and behind the spaceman.
        let targetPosition = SCNVector3((spacemanPosition?.x)!, 30.0, (spacemanPosition?.z)! + 20.0)
        let cameraNode = mainScene.rootNode.childNode(withName: "mainCamera", recursively: true)
        var cameraPosition = cameraNode?.position
        
        let cameraXPos = cameraPosition!.x * (1.0 - cameraDamping) + targetPosition.x * cameraDamping
        let cameraYPos = cameraPosition!.y * (1.0 - cameraDamping) + targetPosition.y * cameraDamping
        let cameraZPos = cameraPosition!.z * (1.0 - cameraDamping) + targetPosition.z * cameraDamping
        
        cameraPosition = SCNVector3(cameraXPos, cameraYPos, cameraZPos)
        
        cameraNode?.position = cameraPosition!
    }
    
    //MARK: Create Main Camera
    func createMainCamera() {
        
        let cameraNode = SCNNode()
        cameraNode.name = "mainCamera"
        cameraNode.camera = SCNCamera()
        cameraNode.camera?.zFar = 1000
        cameraNode.position = SCNVector3(x: 0, y: 15, z: 10)
        cameraNode.rotation = SCNVector4(x: 0, y: 0, z: 0, w: -Float.pi/4 * 0.5) //Float(-M_PI_4*0.75))
        
        let heroNode = mainScene.rootNode.childNode(withName: "hero", recursively: true)
        heroNode?.addChildNode(cameraNode)
        
//        mainScene.rootNode.addChildNode(cameraNode)
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
    
    //MARK: Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let taps = event?.allTouches
        touchCount = taps?.count
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchCount = 0
    }
    
    func setupAccelerometer(){
        
        //Create motion manager to recieve the input
        let motionManager = CMMotionManager()
        if motionManager.isAccelerometerAvailable{
            
            motionManager.accelerometerUpdateInterval = 1/60.0
            motionManager.startAccelerometerUpdates(to: OperationQueue()){ (data,error) in
                let heroNode = self.mainScene.rootNode.childNode(withName: "hero",
                recursively: true)?.presentation
                
                //Get current position
                let currentX = heroNode?.position.x
                let currentY = heroNode?.position.y
                let currentZ = heroNode?.position.z
                let threshold = 0.20
                //Moving Right
                if (data?.acceleration.y)! < -threshold{
                    let destinationX = (Float((data?.acceleration.y)!) * 10.0 - Float(currentX!))
                    let destinationY = Float(currentY!)
                    let destinationZ = Float(currentZ!)
                    let action = SCNAction.move(by: SCNVector3(destinationX, destinationY, destinationZ), duration: 1)
                    heroNode?.runAction(action)
                }else if (data?.acceleration.y)! > threshold{
                    let destinationX = (Float((data?.acceleration.y)!) * 10.0 - Float(currentX!))
                    let destinationY = Float(currentY!)
                    let destinationZ = Float(currentZ!)
                    let action = SCNAction.move(by: SCNVector3(destinationX, destinationY, destinationZ), duration: 1)
                    heroNode?.runAction(action)
                }
            }
        }
    }
    

}

//MARK: Extension Scene Render Delegate
extension GameViewController: SCNSceneRendererDelegate{
    func renderer(_ renderer: SCNSceneRenderer, didSimulatePhysicsAtTime time: TimeInterval) {
        let moveDistance = Float(10.0)
        let moveSpeed = TimeInterval(1.0)
        let heroNode = mainScene.rootNode.childNode(withName: "hero", recursively: true)
        let currentX = heroNode?.position.x
        let currentY = heroNode?.position.y
        let currentZ = heroNode?.position.z
        
        if touchCount == 1{
            let action = SCNAction.move(to: SCNVector3(currentX!, currentY!, currentZ! - moveDistance), duration: moveSpeed)
            heroNode?.runAction(action)
        }else if touchCount == 2{
            let action = SCNAction.move(to: SCNVector3(currentX!, currentY!, currentZ! + moveDistance), duration: moveSpeed)
            heroNode?.runAction(action)
        }else if touchCount == 4{
            let action = SCNAction.move(to: SCNVector3(0, 0, 0), duration: moveSpeed)
            heroNode?.runAction(action)
        }
        
        positionCameraWithSpaceman()
    }
    
}
