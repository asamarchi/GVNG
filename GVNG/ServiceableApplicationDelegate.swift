//
//  ServiceableApplicationDelegate.swift
//
//  Copyright © 2017 PGA Americas. All rights reserved.
//

public protocol GVNGAppService: UIApplicationDelegate { }


open class ServiceableApplicationDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties
    
    public var orientationLock = true
    public var window: UIWindow?
    
    open var services: [GVNGAppService] { return [] }
    
    // MARK: Private
    
    fileprivate lazy var _services: [GVNGAppService] = {
        return self.services
    }()
    
    
    // MARK: - Public

    public func applicationDidFinishLaunching(_ application: UIApplication) {
        _services.forEach { $0.applicationDidFinishLaunching?(application) }
    }

    public func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        //Setup Third Party SDKs
        setupThirdPartySDKs()

        var result = true

        for service in _services {
            if false == service.application?(application, willFinishLaunchingWithOptions: launchOptions) {
                result = false
            }
        }
        
        return result
    }

    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        var result = true

        for service in _services {
            if false == service.application?(application, didFinishLaunchingWithOptions: launchOptions) {
                result = false
            }
        }
        
        return result
    }

    public func applicationDidBecomeActive(_ application: UIApplication) {
        _services.forEach { $0.applicationDidBecomeActive?(application) }
    }

    public func applicationWillResignActive(_ application: UIApplication) {
        _services.forEach { $0.applicationWillResignActive?(application) }
    }

    public func applicationWillEnterForeground(_ application: UIApplication) {
        _services.forEach { $0.applicationWillEnterForeground?(application) }
    }

    public func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        for service in _services {
            if true == service.application?(app, open: url, options: options) {
                return true
            }
        }
        
        return false
    }

    public func application(_ application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
        var result = false
        
        for s in _services {
            if true == s.application?(application, willContinueUserActivityWithType: userActivityType) {
                result = true
            }
        }
        
        return result
    }

    public func application(_ application: UIApplication, continue continueUserActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        var result = false
        
        for s in _services {
            if true == s.application?(application, continue: continueUserActivity, restorationHandler: restorationHandler) {
                result = true
            }
        }
        
        return result
    }

    public func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        _services.forEach { $0.applicationDidReceiveMemoryWarning?(application) }
    }

    public func applicationWillTerminate(_ application: UIApplication) {
        _services.forEach { $0.applicationWillTerminate?(application) }
    }

    public func applicationSignificantTimeChange(_ application: UIApplication) {
        _services.forEach { $0.applicationSignificantTimeChange?(application) }
    }

    public func application(_ application: UIApplication, willChangeStatusBarOrientation newStatusBarOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        _services.forEach { $0.application?(application, willChangeStatusBarOrientation: newStatusBarOrientation, duration: duration) }
    }

    public func application(_ application: UIApplication, didChangeStatusBarOrientation newStatusBarOrientation: UIInterfaceOrientation) {
        _services.forEach { $0.application?(application, didChangeStatusBarOrientation: newStatusBarOrientation) }
    }
    
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        _services.forEach { $0.application?(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)}
    }
    
    public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        _services.forEach { $0.application?(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler) }
    }
}

// Convinience Methods
extension ServiceableApplicationDelegate {
    
    // MARK: - Public
    
    open func setupThirdPartySDKs() {
        FirebaseManager.setup()
        SpotifyManager.shared.setup()
    }
}
