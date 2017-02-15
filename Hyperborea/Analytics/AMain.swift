import Foundation
import Google
import FirebaseAnalytics

class AMain
{
    static let sharedInstance:AMain? = AMain()
    private let kEventSearch:String = "Search"
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
        gai.logger.logLevel = GAILogLevel.verbose
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
        region:String)
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
}
