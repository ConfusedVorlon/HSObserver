//
//  HSKeyPathObserver.swift
//  Rhythm101
//
//  Created by Rob Jonson on 30/07/2020.
//  Copyright © 2020 Tinkerswitch. All rights reserved.
//

import Foundation


public class HSKeyPathObserver:NSObject, HSObserves {
    private var block:([NSKeyValueChangeKey:Any]?)->Void
    private var keyPath:String
    private var options:NSKeyValueObservingOptions
    weak private var object:AnyObject?
    
    
    /// Based on addObserver(_:forKeyPath:options:context:), but with a callback block
    /// - Parameters:
    ///   - keyPath: the string key path to observe
    ///   - object: the object you want to observe
    ///   - options: NSKeyValueObservingOptions
    ///   - activate: whether to immediately activate the observer
    ///   - block: the block to call when there is a change
    public init(forKeyPath keyPath: String,of object: AnyObject, options: NSKeyValueObservingOptions = [],activate:Bool = false, block:@escaping ([NSKeyValueChangeKey:Any]?)->Void ){
        self.block = block
        self.keyPath = keyPath
        self.options = options
        self.object = object
        
        super.init()
        
        if activate {
            self.activate()
        }
    }
    
    deinit {
        deactivate()
    }
    
    @discardableResult
    public func activate() -> Self {
        object?.addObserver(self,
                           forKeyPath: keyPath,
                           options: options,
                           context: nil)
        
        return self
    }
    
    public func deactivate() {
        object?.removeObserver(self, forKeyPath: keyPath)
    }
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?)
    {
        block(change)
    }
    
    open override var description:String {
        return "KeyPathObserver: \(keyPath) - object: \(String(describing: object)) - options:\(options)"
    }
}
