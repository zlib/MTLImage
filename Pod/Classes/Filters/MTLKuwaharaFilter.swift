//
//  MTLKuwaharaFilter.swift
//  Pods
//
//  Created by Mohssen Fathi on 4/8/16.
//
//

import UIKit

struct KuwaharaUniforms {
    var radius: Float = 0.5
}

public
class MTLKuwaharaFilter: MTLFilter {
    
    var uniforms = KuwaharaUniforms()
    
    public var radius: Float = 0.5 {
        didSet {
            clamp(&radius, low: 0, high: 1)
            needsUpdate = true
            update()
        }
    }
    
    public init() {
        super.init(functionName: "kuwahara")
        title = "Kuwahara"
        properties = [MTLProperty(key: "radius", title: "Radius")]
        update()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func update() {
        if self.input == nil { return }
        uniforms.radius = round(Tools.convert(radius, oldMin: 0, oldMax: 1, newMin: 1, newMax: 10))
        uniformsBuffer = device.newBuffer(withBytes: &uniforms, length: sizeof(KuwaharaUniforms), options: .cpuCacheModeWriteCombined)
    }
}
