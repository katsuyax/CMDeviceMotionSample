//
//  InterfaceController.swift
//  CMDeviceMotionSample WatchKit Extension
//
//  Created by katsuya.kato on 2016/12/06.
//  Copyright © 2016年 CrossBridge. All rights reserved.
//

import WatchKit
import Foundation
import CoreMotion

class InterfaceController: WKInterfaceController {
    
    @IBOutlet var gravityLabel: WKInterfaceLabel!
    @IBOutlet var rotationRateLabel: WKInterfaceLabel!
    @IBOutlet var magneticFieldLabel: WKInterfaceLabel!
    @IBOutlet var attitudeLabel: WKInterfaceLabel!
    let motionManager = CMMotionManager()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        super.willActivate()
        
        let handler: CMDeviceMotionHandler = {(motion: CMDeviceMotion?, error: Error?) -> Void in
            if let motion = motion {
                // 加速度センサ
                let gravity = "\(String(format: "X:%.2f", motion.gravity.x)),\(String(format: "Y:%.2f", motion.gravity.y)),\(String(format: "Z:%.2f", motion.gravity.z))"
                self.gravityLabel.setText(gravity)
                print("gravity \(gravity)")
                
                // ジャイロスコープ
                let rotation = "\(String(format: "X:%.2f", motion.rotationRate.x)),\(String(format: "Y:%.2f", motion.rotationRate.y)),\(String(format: "Z:%.2f", motion.rotationRate.z))"
                self.rotationRateLabel.setText(rotation)
                print("rotationRate (\(rotation)")
                
                // 姿勢
                let attitude = "\(String(format: "roll:%.2f", motion.attitude.roll)),\(String(format: "yaw:%.2f", motion.attitude.yaw)),\(String(format: "pitch%.2f", motion.attitude.pitch))"
                self.attitudeLabel.setText(attitude)
                print("attitude \(attitude)")
            }
        }
        
        if motionManager.isDeviceMotionAvailable {
            motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: handler)
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}
