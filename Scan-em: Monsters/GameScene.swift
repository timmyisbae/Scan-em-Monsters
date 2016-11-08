import SpriteKit
import AVFoundation

class GameScene: SKScene, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let background = SKSpriteNode(imageNamed: "homescreen")
        background.size = size
        //addChild(background)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let slizzle1 = SKSpriteNode(imageNamed: "slizzle")
            slizzle1.xScale = 0.5
            slizzle1.yScale = 0.5
            slizzle1.position = location
            self.addChild(slizzle1)
            print("hh")
            
        }
    }
    

}


