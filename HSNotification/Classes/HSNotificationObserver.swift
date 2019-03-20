//
//  HSNotificationObserver.swift
//  ChillRemote
//
//  Created by Rob Jonson on 04/07/2018.
//  Copyright © 2018 HobbyistSoftware. All rights reserved.
//

import Foundation

protocol HSNotificationObserver {
    var observers:[HSNotification] {get set}
    func activateObservers()
    func deactivateObservers()
    mutating func add(observer:HSNotification)
}

private var observerKey: Void?
extension HSNotificationObserver {
    private func _getObservers() -> [HSNotification] {
        guard let existing = objc_getAssociatedObject(self, &observerKey) as? [HSNotification] else {
            return [HSNotification]()
        }
        
        return existing
    }
    
    private func _setObservers(_ newValue:[HSNotification]) {
        let objcArray = newValue as NSArray
        objc_setAssociatedObject(self,
                                 &observerKey, objcArray,
                                 .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

    }
    
    var observers: [HSNotification] {
        get {
            return _getObservers()
        }
        set {
            _setObservers(newValue)
        }
    }
    
    func activateObservers() {
        observers.forEach { (notif) in
            notif.activate()
        }
    }
    
    func deactivateObservers() {
        observers.forEach { (notif) in
            notif.deactivate()
        }
    }
    
    func add(observers newObservers:[HSNotification]) {
        var mutableObservers = observers
        mutableObservers.append(contentsOf: newObservers)
        _setObservers(mutableObservers)
    }
    
    func add(observer:HSNotification) {
        self.add(observers: [observer])
    }
    
}

extension HSNotification {
    func add(to:HSNotificationObserver) {
        to.add(observer: self)
    }
}
