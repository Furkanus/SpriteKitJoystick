//
//  GameScene.swift
//  JoystickWithSpriteKit
//
//  Created by Furkan Hanci on 7/10/20.
//

import SpriteKit


class GameScene: SKScene {
    var appleNode: SKSpriteNode?
    let jSizePlusSpriteNode = SKSpriteNode(imageNamed: "plus")
    let jSizeMinusSpriteNode = SKSpriteNode(imageNamed: "minus")
    let setJoystickStickImageBtn = SKLabelNode()
    let setJoystickSubstrateImageBtn = SKLabelNode()
   // let joystickStickColorBtn = SKLabelNode(text: "Joystick rastgele renk")
    //let joystickSubstrateColorBtn = SKLabelNode(text: "Rstgele Renk")
    
    let moveJoystick = 🕹(withDiameter: 100)
    let rotateJoystick = TLAnalogJoystick(withDiameter: 100)
    
    var joystickStickImageEnabled = true {
        didSet {
            let image = joystickStickImageEnabled ? UIImage(named: "jStick") : nil
            moveJoystick.handleImage = image
            rotateJoystick.handleImage = image
            setJoystickStickImageBtn.text = "\(joystickStickImageEnabled ? "Sil" : "Ayarla") joystick rengi"
        }
    }
    
    var joystickSubstrateImageEnabled = true {
        didSet {
            let image = joystickSubstrateImageEnabled ? UIImage(named: "jSubstrate") : nil
            moveJoystick.baseImage = image
            rotateJoystick.baseImage = image
            setJoystickSubstrateImageBtn.text = "\(joystickSubstrateImageEnabled ? "Rastgele" : "Ayarla") joystick rengi"
        }
    }
    
    override func didMove(to view: SKView) {
        
        backgroundColor = .white
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)

        let moveJoystickHiddenArea = AnalogJoystickHiddenArea(rect: CGRect(x: 0, y: 0, width: frame.midX, height: frame.height))
        moveJoystickHiddenArea.joystick = moveJoystick
        moveJoystick.isMoveable = true
        addChild(moveJoystickHiddenArea)
        
        let rotateJoystickHiddenArea = AnalogJoystickHiddenArea(rect: CGRect(x: frame.midX, y: 0, width: frame.midX, height: frame.height))
        rotateJoystickHiddenArea.joystick = rotateJoystick
        addChild(rotateJoystickHiddenArea)
        
        
        moveJoystick.on(.begin) { [unowned self] _ in
            let actions = [
                SKAction.scale(to: 0.5, duration: 0.5),
                SKAction.scale(to: 1, duration: 0.5)
            ]

            self.appleNode?.run(SKAction.sequence(actions))
        }
        
        moveJoystick.on(.move) { [unowned self] joystick in
            guard let appleNode = self.appleNode else {
                return
            }
            
            let pVelocity = joystick.velocity;
            let speed = CGFloat(0.12)
            
            appleNode.position = CGPoint(x: appleNode.position.x + (pVelocity.x * speed), y: appleNode.position.y + (pVelocity.y * speed))
        }
        
        moveJoystick.on(.end) { [unowned self] _ in
            let actions = [
                SKAction.scale(to: 1.5, duration: 0.5),
                SKAction.scale(to: 1, duration: 0.5)
            ]

            self.appleNode?.run(SKAction.sequence(actions))
        }
        
        rotateJoystick.on(.move) { [unowned self] joystick in
            guard let appleNode = self.appleNode else {
                return
            }

            appleNode.zRotation = joystick.angular
        }
        
        rotateJoystick.on(.end) { [unowned self] _ in
            self.appleNode?.run(SKAction.rotate(byAngle: 3.6, duration: 0.5))
        }
        
        
        let selfHeight = frame.height
        let btnsOffset: CGFloat = 10
        let btnsOffsetHalf = btnsOffset / 2
        let joystickSizeLabel = SKLabelNode(text: "Joystick Boyutu:")
        joystickSizeLabel.fontSize = 20
        joystickSizeLabel.fontColor = UIColor.black
        joystickSizeLabel.horizontalAlignmentMode = .left
        joystickSizeLabel.verticalAlignmentMode = .top
        joystickSizeLabel.position = CGPoint(x: btnsOffset, y: selfHeight - btnsOffset)
        addChild(joystickSizeLabel)
        
       // joystickStickColorBtn.fontColor = UIColor.black
        //joystickStickColorBtn.fontSize = 20
        //joystickStickColorBtn.verticalAlignmentMode = .top
        //joystickStickColorBtn.horizontalAlignmentMode = .left
        //joystickStickColorBtn.position = CGPoint(x: btnsOffset, y: selfHeight - 40)
        //addChild(joystickStickColorBtn)
        
        //joystickSubstrateColorBtn.fontColor = UIColor.black
        //joystickSubstrateColorBtn.fontSize = 20
        //joystickSubstrateColorBtn.verticalAlignmentMode = .top
        //joystickSubstrateColorBtn.horizontalAlignmentMode = .left
        //joystickSubstrateColorBtn.position = CGPoint(x: btnsOffset, y: selfHeight - 65)
        //addChild(joystickSubstrateColorBtn)
        
        jSizeMinusSpriteNode.anchorPoint = CGPoint(x: 0, y: 0.5)
        jSizeMinusSpriteNode.position = CGPoint(x: joystickSizeLabel.frame.maxX + btnsOffset, y: joystickSizeLabel.frame.midY)
        addChild(jSizeMinusSpriteNode)
        
        jSizePlusSpriteNode.anchorPoint = CGPoint(x: 0, y: 0.5)
        jSizePlusSpriteNode.position = CGPoint(x: jSizeMinusSpriteNode.frame.maxX + btnsOffset, y: joystickSizeLabel.frame.midY)
        addChild(jSizePlusSpriteNode)
        
        let startLabelY = CGFloat(40)
        
        setJoystickStickImageBtn.fontColor = UIColor.black
        setJoystickStickImageBtn.fontSize = 20
        setJoystickStickImageBtn.verticalAlignmentMode = .bottom
        setJoystickStickImageBtn.position = CGPoint(x: frame.midX, y: startLabelY - btnsOffsetHalf)
        addChild(setJoystickStickImageBtn)
        
        setJoystickSubstrateImageBtn.fontColor  = UIColor.black
        setJoystickSubstrateImageBtn.fontSize = 20
        setJoystickStickImageBtn.verticalAlignmentMode = .top
        setJoystickSubstrateImageBtn.position = CGPoint(x: frame.midX, y: startLabelY + btnsOffsetHalf)
        addChild(setJoystickSubstrateImageBtn)
        joystickStickImageEnabled = true
        joystickSubstrateImageEnabled = true

        addApple(CGPoint(x: frame.midX, y: frame.midY))

        view.isMultipleTouchEnabled = true
    }
    
    func addApple(_ position: CGPoint) {
        guard let appleImage = UIImage(named: "apple") else {
            return
        }
        
        let texture = SKTexture(image: appleImage)
        let apple = SKSpriteNode(texture: texture)
        apple.physicsBody = SKPhysicsBody(texture: texture, size: apple.size)
        apple.physicsBody!.affectedByGravity = false
        apple.position = position
        addChild(apple)
        appleNode = apple
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        
        if let touch = touches.first {
            let node = atPoint(touch.location(in: self))
            
            switch node {
            case jSizePlusSpriteNode:
                moveJoystick.diameter += 10
                rotateJoystick.diameter += 10
            case jSizeMinusSpriteNode:
                moveJoystick.diameter -= 10
                rotateJoystick.diameter -= 10
            case setJoystickStickImageBtn:
                joystickStickImageEnabled = !joystickStickImageEnabled
            case setJoystickSubstrateImageBtn:
                joystickSubstrateImageEnabled = !joystickSubstrateImageEnabled
          //  case joystickStickColorBtn:
                setRandomStickColor()
           // case joystickSubstrateColorBtn:
                setRandomSubstrateColor()
            default:
                addApple(touch.location(in: self))
            }
        }
    }
    
    func setRandomStickColor() {
        let randomColor = UIColor.random()
        moveJoystick.handleColor = randomColor
        rotateJoystick.handleColor = randomColor
    }
    
    func setRandomSubstrateColor() {
        let randomColor = UIColor.random()
        moveJoystick.baseColor = randomColor
        rotateJoystick.baseColor = randomColor
    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1)
    }
}
