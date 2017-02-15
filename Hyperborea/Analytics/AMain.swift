import Foundation
import Google
import FirebaseAnalytics

class AMain
{
    enum FroobAction:String
    {
        case searchClose = "Search/Close"
        case searchStore = "Search/Store"
    }
    
    enum StoreAction:String
    {
        case purchase = "Purchase"
        case restore = "Restore"
    }
    
    static let sharedInstance:AMain? = AMain()
    private let kEventSearch:String = "Search"
    private let kEventLanguage:String = "Language"
    private let kEventFroob:String = "Froob"
    private let kEventStore:String = "Store"
    private let kEventValue:NSNumber = 1
    private let kDispatchInterval:TimeInterval = 30
    
    private init?()
    {
        var configurationError:NSError?
        
        GGLContext.sharedInstance().configureWithError(&configurationError)
        
        if let configurationError:NSError = configurationError
        {
            print(configurationError.localizedDescription)
            
            return nil
        }
    }
    
    //MARK: public
    
    func startAnalytics()
    {
        guard
        
            let gai:GAI = GAI.sharedInstance()
        
        else
        {
            return
        }
        
        gai.trackUncaughtExceptions = true
        gai.logger.logLevel = GAILogLevel.none
        gai.dispatchInterval = kDispatchInterval
    }
    
    func trackScreen(screen:UIViewController)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            guard
            
                let tracker:GAITracker = GAI.sharedInstance().defaultTracker
            
            else
            {
                return
            }
            
            let screenName:String = String(describing:type(of:screen))
            tracker.set(kGAIScreenName, value:screenName)
            let screenBuild:[NSObject:AnyObject] = GAIDictionaryBuilder.createScreenView().build() as [NSObject:AnyObject]
            tracker.send(screenBuild)
        }
    }
    
    func trackSearch(
        wordId:String,
        region:String?)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            guard
                
                let tracker:GAITracker = GAI.sharedInstance().defaultTracker
                
            else
            {
                return
            }
            
            let eventBuild:[NSObject:AnyObject] = GAIDictionaryBuilder.createEvent(
                withCategory:self.kEventSearch,
                action:wordId,
                label:region,
                value:self.kEventValue).build() as [NSObject:AnyObject]
            tracker.send(eventBuild)
        }
    }
    
    func trackLanguage(name:String)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            guard
                
                let tracker:GAITracker = GAI.sharedInstance().defaultTracker
                
            else
            {
                return
            }
            
            let eventBuild:[NSObject:AnyObject] = GAIDictionaryBuilder.createEvent(
                withCategory:self.kEventLanguage,
                action:name,
                label:nil,
                value:self.kEventValue).build() as [NSObject:AnyObject]
            tracker.send(eventBuild)
        }
    }
    
    func trackFroob(action:FroobAction)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            guard
                
                let tracker:GAITracker = GAI.sharedInstance().defaultTracker
                
            else
            {
                return
            }
            
            let eventBuild:[NSObject:AnyObject] = GAIDictionaryBuilder.createEvent(
                withCategory:self.kEventFroob,
                action:action.rawValue,
                label:nil,
                value:self.kEventValue).build() as [NSObject:AnyObject]
            tracker.send(eventBuild)
        }
    }
    
    func trackStore(action:StoreAction, purchase:String?)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            guard
                
                let tracker:GAITracker = GAI.sharedInstance().defaultTracker
                
            else
            {
                return
            }
            
            let eventBuild:[NSObject:AnyObject] = GAIDictionaryBuilder.createEvent(
                withCategory:self.kEventStore,
                action:action.rawValue,
                label:purchase,
                value:self.kEventValue).build() as [NSObject:AnyObject]
            tracker.send(eventBuild)
        }
    }
}
