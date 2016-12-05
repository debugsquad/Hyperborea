import Foundation

class RSettings
{
    enum SettingsId
    {
        case unknown
    }
    
    enum Method:String
    {
        case get = "GET"
        case post = "POST"
    }
    
    static let kTimeOut:TimeInterval = 20
    let settingsId:SettingsId
    let method:Method
    let urlString:String
    let timeOut:TimeInterval
    private let kCachePolicy:URLRequest.CachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
    private let kCellularAccess:Bool = true
    
    init(
        settingsId:SettingsId,
        method:Method,
        urlString:String,
        timeOut:TimeInterval = kTimeOut)
    {
        self.settingsId = settingsId
        self.method = method
        self.urlString = urlString
        self.timeOut = timeOut
    }
    
    init()
    {
        fatalError()
    }
    
    //MARK: public
    
    func request(settings:RSettings) -> URLRequest?
    {
        let urlRequest:NSMutableURLRequest
        
        #if DEBUG
            
            print(settings.urlString)
            
        #endif
        
        guard
            
            let url:URL = URL(string:settings.urlString)
        
        else
        {
            return nil
        }
        
        urlRequest = NSMutableURLRequest(
            url:url,
            cachePolicy:kCachePolicy,
            timeoutInterval:settings.timeOut)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allowsCellularAccess = kCellularAccess
        headers(settings:settings, request:&urlRequest)
        
        return urlRequest
    }
}
