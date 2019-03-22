# HSNotification

[![Version](https://img.shields.io/cocoapods/v/HSObserver.svg?style=flat)](https://cocoapods.org/pods/HSObserver)
[![License](https://img.shields.io/cocoapods/l/HSObserver.svg?style=flat)](https://cocoapods.org/pods/HSObserver)
[![Platform](https://img.shields.io/cocoapods/p/HSObserver.svg?style=flat)](https://cocoapods.org/pods/HSObserver)

## Summary

Better Notification Observers for Swift.

* Simpler API with sensible defaults
* Easier to avoid 'dangling' observers
* Easy activation/deactivation
* Simple integration with view controller lifecycles


## Installation

HSObserver is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'HSObserver'
```

## Observers are Released

```swift
class Watcher {
    static let wave = NSNotification.Name.init("waveNotification")

    var waveObserver:HSObserver
    init() {
        waveObserver = HSObserver.init(forName: Watcher.wave,
                                           activate:true,
                                           using: { (notif) in
            //Do Something
        })
    }
}
```

Unlike a standard observer, waveObserver is fully released when Watcher is released. (Posting a wave notification will not call the `//Do Something` code)

## Observers can be Activated and Deactivated

```swift
    var waveObserver:HSObserver
    init() {
        waveObserver = HSObserver.init(forName: Watcher.wave,
                                           using: { (notif) in
            //Do Something
        })

        //activate
        waveObserver.activate()

        //deactivate
        waveObserver.deactivate()
    }
```

N.B. Remember that you have to activate your observer for it to work.

* either specify `activate:true` in the initialiser
* or call myObserver.activate()`
* or chain on the initialiser `HSObserver.init(....).activate()`


## HSHasObservers integrates well with View Controller lifecycle

A common pattern for a view controller is to activate observers in `viewWillAppear`, and de-activate them in `viewDidDisppear`

Adding the `HSHasObservers` protocol to any class allows you to add a group of observers, and activate or deactivate them easily.

Observers can be added manually, or by chaining .add(to:self) to an HSObserver

```swift
class ViewController: NSViewController, HSHasObservers {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Add manually
        let waveObserver = HSObserver.init(forName: Watcher.wave,
                                           using: { (notif) in
                                            //Do Something
        })
        self.add(observer: waveObserver)

        //Or by chaining
        HSObserver.init(forName: Watcher.wave,
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

## Add Multiple Observers

```swift
        let manyThingsObserver = HSObserver.init(forNames: [Watcher.wave,Watcher.hello] ,
                                                     activate:true,
                                           using: { (notif) in
                                            //Do Something
        })
```

## Specify centre, queue, etc

```swift
    /// Create observer
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

HSObservers lets you skip the defaults. We assume

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
