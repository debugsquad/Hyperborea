import Foundation
import Google
import FirebaseAnalytics

class AMain
{
    static let sharedInstance:AMain? = AMain()
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
    
    func trackScreen(name:String)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            GAI.sharedInstance().defaultTracker.send([kGAIScreenName:name])
        }
    }
    
    func trackEvent(name:String)
    {
        
    }
}
