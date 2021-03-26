# HSObserver

[![Version](https://img.shields.io/cocoapods/v/HSObserver.svg?style=flat)](https://cocoapods.org/pods/HSObserver)
[![License](https://img.shields.io/cocoapods/l/HSObserver.svg?style=flat)](https://cocoapods.org/pods/HSObserver)
[![Platform](https://img.shields.io/cocoapods/p/HSObserver.svg?style=flat)](https://cocoapods.org/pods/HSObserver)

## Summary

Better Notification & Key Value Observers for Swift.

* Simpler API with sensible defaults
* Easier to avoid 'dangling' observers
* Delivers on main thread by default (avoid unexpected concurrency bugs)
* Easy activation/deactivation
* Simple integration with view controller lifecycles


## Installation

HSObserver is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'HSObserver'
```

Or Install as a swift package


## Observers are Released Automatically

```swift
class Watcher {
    struct Notif {
        static let wave = NSNotification.Name.init("waveNotification")
    }
    

    var waveObserver:HSObserver
    init() {
        waveObserver = HSObserver.init(forName: Watcher.Notif.wave,
                                           activate:true,
                                           using: { (notif) in
            //Do Something
        })
    }
}
```

Unlike a standard observer, waveObserver is fully released when Watcher is released. 

(Posting a wave notification will not call the `//Do Something` code once Watcher is released)

## Delivery happens on the main thread

It's easy to get bitten by notifications unexpectedly arriving on a background thread. In almost all cases - [you don't want that!](https://inessential.com/2021/03/20/how_netnewswire_handles_threading)
.

(you can change this for a given observer if you want to - but you probably shouldn't)

## Observers can be Activated and Deactivated

```swift
    var waveObserver:HSObserver
    init() {
        waveObserver = HSObserver.init(forName: Watcher.Notif.wave,
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
        let waveObserver = HSObserver.init(forName: Watcher.Notif.wave,
                                           using: { (notif) in
                                            //Do Something
        })
        self.add(observer: waveObserver)

        //Or by chaining
        HSObserver.init(forName: Watcher.Notif.wave,
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
    let manyThingsObserver = HSObserver.init(forNames: [Watcher.Notif.wave,Watcher.Notif.hello] ,
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

Brent Simmons has a [great article](https://inessential.com/2021/03/20/how_netnewswire_handles_threading) on why you should almost always be using .main

## Convenience functions on NSNotification.Name

Post a notification directly
  
  ```swift
  class Watcher {
    struct Notif {
        static let wave = NSNotification.Name.init("waveNotification")
    }
      

    func doPosting() {
        Watcher.Notif.wave.post()
        //or
        Watcher.Notif.wave.post(object:self,userInfo:["Foo":"Bar"])
    }
  }
  ```

Assume the default notification centre and default options when posting directly from NotificationCenter
(I strongly reccomend that you structure your notifications within a Notif struct of the relevant object. It makes things really easy to read)

  ```swift
  
  NotificationCenter.post(Watcher.Notif.wave)
  //is equivalent to
  NotificationCenter.default.post(Watcher.wave,object:nil)
  
  ```
    
## Now with Key Value Notifications

for example, to observe the duration of an AVPlayerItem

  ```swift
durationObserver = HSKeyPathObserver.init(forKeyPath: "duration",
                                          of: item,
                                          activate:true) {
                                            [weak self](_) in
                                            self?.generateImages()
}
  ```
  
  (again, remember to keep a reference to durationObserver or it will disappear)
    

## Author

ConfusedVorlon, rob@hobbyistsoftware.com

## License

HSNotification is available under the MIT license. See the LICENSE file for more info.
