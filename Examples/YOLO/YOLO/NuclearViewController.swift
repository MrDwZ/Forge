//
//  NuclearViewController.swift
//  YOLO
//
//  Created by HOPE on 5/3/18.
//  Copyright © 2018 MachineThink. All rights reserved.
//

import Foundation
import UIKit
import MetalKit
import Forge

class NuclearViewController: UIViewController {
    @IBOutlet weak var test: UIButton!
    @IBAction func nuclearStart() {
        let image = UIImage(named: "dog")?.cgImage
        let device = MTLCreateSystemDefaultDevice()
        let textureLoader = MTKTextureLoader(device: device!)
        
        let texture: MTLTexture = try! textureLoader.newTexture(cgImage: image!)
        
        let MaxBuffersInFlight = 3
        let commandQueue = device!.makeCommandQueue()
        
        let runner = Runner(commandQueue: commandQueue!, inflightBuffers: MaxBuffersInFlight)
        let network = YOLO(device: device!, inflightBuffers: MaxBuffersInFlight)
        
        runner.predict(network: network, texture: texture, queue: .main) { result in
            print(result.predictions.count)
            print(result)
        }
        
        print(texture.height)
        print(texture.width)
    }
}
