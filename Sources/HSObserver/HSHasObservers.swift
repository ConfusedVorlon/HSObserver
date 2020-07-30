//
//  HSHasObservers.swift
//  ChillRemote
//
//  Created by Rob Jonson on 04/07/2018.
//  Copyright © 2018 HobbyistSoftware. All rights reserved.
//

import Foundation

/// Add this protocol to any object which owns observers.
/// You can then add the HSObserver directly to the object, and use activateObservers(), deactivateObservers()
public protocol HSHasObservers {
    var observers:[HSObserves] {get set}
    func activateObservers()
    func deactivateObservers()
    mutating func add(observer:HSObserves)
}

private var observerKey: Void?
public extension HSHasObservers {
    private func _getObservers() -> [HSObserves] {
        guard let existing = objc_getAssociatedObject(self, &observerKey) as? [HSObserves] else {
            return [HSObserver]()
        }

        return existing
    }

    private func _setObservers(_ newValue:[HSObserves]) {
        let objcArray = newValue as NSArray
        objc_setAssociatedObject(self,
                                 &observerKey, objcArray,
                                 .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    var observers: [HSObserves] {
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

    func add(observers newObservers:[HSObserves]) {
        var mutableObservers = observers
        mutableObservers.append(contentsOf: newObservers)
        _setObservers(mutableObservers)
    }

    func add(observer:HSObserves) {
        self.add(observers: [observer])
    }
}

public extension HSObserves {
    func add(to:HSHasObservers) {
        to.add(observer: self)
    }
}
