import Foundation
import Google
import FirebaseAnalytics

class AMain
{
    static let sharedInstance:AMain? = AMain()
    
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
    }
}
