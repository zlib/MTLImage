//
//  Distortion.swift
//  Pods
//
//  Created by Mohssen Fathi on 4/22/16.
//
//

import UIKit

struct DistortionUniforms: Uniforms {
    var centerX: Float = 0.5;
    var centerY: Float = 0.5;
}

public
class Distortion: Filter {
    
    var uniforms = DistortionUniforms()
    
    public var x: Float = 0.5 {
        didSet {
            clamp(&x, low: 0, high: 1)
            needsUpdate = true
        }
    }
    
    public var y: Float = 0.5 {
        didSet {
            clamp(&y, low: 0, high: 1)
            needsUpdate = true
        }
    }
    
    public init() {
        super.init(functionName: "distortion")
        title = "Distortion"
        properties = [
            Property<Distortion, Float>(title: "X", keyPath: \Distortion.x),
            Property<Distortion, Float>(title: "Y", keyPath: \Distortion.y)
        ]
    }

    override func update() {
        if self.input == nil { return }
        uniforms.centerX = x
        uniforms.centerY = y
        updateUniforms(uniforms: uniforms)
    }
    
}