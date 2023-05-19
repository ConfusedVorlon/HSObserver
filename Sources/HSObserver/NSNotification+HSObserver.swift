//
//  NSNotification+HSObserver.swift
//  HSObserver
//
//  Created by Rob Jonson on 07/10/2019.
//

import Foundation

public extension NSNotification.Name {
    
    /// Convenience method to allow Notif.myNotification.post()
    /// - Parameters:
    ///   - object: the poster
    ///   - userInfo: user info
    func post(object:Any? = nil,
              userInfo:[AnyHashable : Any]? = nil) {
        NotificationCenter.default.post(name:self,object:object,userInfo: userInfo)
    }
}

public extension NotificationCenter {
    
    /// Sugar to change NotificationCenter.default.post(...) to NotificationCentre.post(...)
    /// - Parameters:
    ///   - aName: the notification
    ///   - anObject: object
    ///   - aUserInfo: userInfo
    @objc
    class func post(name aName: NSNotification.Name,
                    object anObject: Any? = nil,
                    userInfo aUserInfo: [AnyHashable : Any]? = nil) {
        NotificationCenter.default.post(name: aName, object: anObject, userInfo: aUserInfo)
    }
    
}
