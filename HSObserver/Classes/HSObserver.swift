//
//  HSObserver.swift

//
//  Created by Rob Jonson on 01/09/2016.
//  Copyright © 2016 HobbyistSoftware. All rights reserved.
//

import Foundation

@available(*, deprecated,renamed: "HSObserver")
public typealias HSNotification = HSObserver

/// Set up an NSNotification block observer which can be started and stopped
open class HSObserver: CustomStringConvertible {
    open var centre:NotificationCenter
    open var names = [NSNotification.Name]()
    open var name:NSNotification.Name? {
        get {
            return names.first
        }
    }
    open var object:Any?
    open var queue:OperationQueue?
    open var block:((Notification) -> Swift.Void)

    open var notificationObservers = [NSObjectProtocol]()


    /// Create observer
    ///
    /// - parameter name:  notification name
    /// - parameter obj:   object to observe (default nil)
    /// - parameter queue: queue to run the block on (default main)
    /// - parameter center: notification center (default NotificationCenter.default)
    /// - parameter block: block to run (beware of retain cycles!)
    ///
    /// - returns: unactivated manager. Call activate() to start
    public convenience init(forName name: NSNotification.Name, object obj: Any? = nil,
                     queue: OperationQueue? = .main,
                     center newCenter: NotificationCenter = NotificationCenter.default,
                     activate: Bool = false,
                     using block: @escaping (Notification) -> Swift.Void) {

        self.init(forNames: [name], object: obj, queue: queue, center: newCenter, activate: activate, using: block)
    }

    /// Create observer for multiple notifications
    ///
    /// - parameter names:  notification names
    /// - parameter obj:   object to observe (default nil)
    /// - parameter queue: queue to run the block on (default main)
    /// - parameter activate: whether to activate immediately (default false)
    /// - parameter block: block to run (beware of retain cycles!)
    ///
    /// - returns: unactivated manager. Call activate() to start
    public init(forNames names: [NSNotification.Name], object obj: Any? = nil,
         queue: OperationQueue? = .main,
         center newCenter: NotificationCenter = NotificationCenter.default,
         activate: Bool = false,
         using block: @escaping (Notification) -> Swift.Void) {


        self.centre = newCenter
        self.names = names
        self.object = obj
        self.queue = queue
        self.block = block

        if activate {
            self.activate()
        }
    }

    deinit {
        deactivate()
    }

    open var description:String {
        return "Observer: \(String(describing: names)) - object: \(String(describing: object))"
    }


    /// Activate
    @discardableResult
    open func activate() -> HSObserver {
        if notificationObservers.count == 0 {
            for name in names {
                let notificationObserver = centre.addObserver(forName: name,
                                                                              object: object,
                                                                              queue: queue,
                                                                              using: block)
                notificationObservers.append(notificationObserver)
            }
        }

        return self
    }

    /// Deactivate (this happens automatically on release
    open func deactivate() {
        for notificationObserver in notificationObservers {
            centre.removeObserver(notificationObserver)
        }

        notificationObservers.removeAll()
    }
}
