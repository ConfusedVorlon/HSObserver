# HSNotification

[![CI Status](https://img.shields.io/travis/ConfusedVorlon/HSNotification.svg?style=flat)](https://travis-ci.org/ConfusedVorlon/HSNotification)
[![Version](https://img.shields.io/cocoapods/v/HSNotification.svg?style=flat)](https://cocoapods.org/pods/HSNotification)
[![License](https://img.shields.io/cocoapods/l/HSNotification.svg?style=flat)](https://cocoapods.org/pods/HSNotification)
[![Platform](https://img.shields.io/cocoapods/p/HSNotification.svg?style=flat)](https://cocoapods.org/pods/HSNotification)

## Summary

Better Notifications for Swift.

* Simpler API with sensible defaults
* Easier to avoid 'dangling' notifications
* Easy activation/deactivation
* Simple integration with view controller lifecycles 


## Installation

HSNotification is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'HSNotification'
```

## Notifications are Released

```swift
class Watcher {
    static let wave = NSNotification.Name.init("waveNotification")
    
    var waveObserver:HSNotification
    init() {
        waveObserver = HSNotification.init(forName: Watcher.wave,
                                           activate:true,
                                           using: { (notif) in
            //Do Something
        })
    }
}
```

Unlike a standard notification, waveObserver is fully released when Watcher is released. (Posting a wave notification will not call the `//Do Something` code)

## Notifications can be Activated and Deactivated

```swift
    var waveObserver:HSNotification
    init() {
        waveObserver = HSNotification.init(forName: Watcher.wave,
                                           using: { (notif) in
            //Do Something
        })
        
        //activate
        waveObserver.activate()
        
        //deactivate
        waveObserver.deactivate()
    }
```

N.B. Remember that you have to activate your notification for it to work. 

* either specify `activate:true` in the initialiser
* or call myObserver.activate()`
* or chain on the initialiser `HSNotification.init(....).activate()`


## HSNotificationObserver integrates well with View Controller lifecycle

A common pattern for a view controller is to activate observers in `viewWillAppear`, and de-activate them in `viewDidDisppear`

Adding the `HSNotificationObserver` protocol to any class allows you to add a group of observers, and activate or deactivate them easily.

Observers can be added manually, or by chaining .add(to:self) to an HSNotification

```swift
class ViewController: NSViewController, HSNotificationObserver {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add manually
        let waveObserver = HSNotification.init(forName: Watcher.wave,
                                           using: { (notif) in
                                            //Do Something
        })
        self.add(observer: waveObserver)
        
        //Or by chaning
        HSNotification.init(forName: Watcher.wave,
                            using: { (notif) in
                                //Do Something
        }).add(to: self)
    }
}
```

this works well with the view lifecycle

```swift    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        activateObservers()
    }
    
    override func viewDidDisappear() {
        super.viewDidDisappear()
        
        deactivateObservers()
    }
```

## Add Multiple Notifications

```swift 
        let manyThingsObserver = HSNotification.init(forNames: [Watcher.wave,Watcher.hello] ,
                                                     activate:true,
                                           using: { (notif) in
                                            //Do Something
        })
```

## Specify centre, queue, etc

```swift 
    /// Create notification manager
    ///
    /// - parameter name:  notification name
    /// - parameter obj:   object to observe (default nil)
    /// - parameter queue: queue to run the block on (default main)
    /// - parameter center: notification center (default NotificationCenter.default)
    /// - parameter block: block to run (beware of retain cycles!)
    ///
    /// - returns: unactivated manager. Call activate() to start
    convenience init(forName name: NSNotification.Name, 
                     object obj: Any? = nil,
                     queue: OperationQueue? = .main,
                     center newCenter: NotificationCenter = NotificationCenter.default,
                     activate: Bool = false,
                     using block: @escaping (Notification) -> Swift.Void)
```

HSNotifications lets you skip the defaults. We assume

* object = nil
* queue = .main
* center = NotificationCenter.default
* activate = false

you can override each of these in the initialiser

Note that Apple's default is to call your block on the same queue as the sender. If you want to do this, then just use centre = nil

I find that I typically want to use notifications to update the UI - so my default is to use .main

## Author

ConfusedVorlon, rob@hobbyistsoftware.com

## License

HSNotification is available under the MIT license. See the LICENSE file for more info.
