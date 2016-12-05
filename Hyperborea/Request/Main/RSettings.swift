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
    let model:RModel.Type
    let headers:[String:String]?
    let settingsId:SettingsId
    let method:Method
    let urlString:String
    let timeOut:TimeInterval
    private let kCachePolicy:URLRequest.CachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
    private let kCellularAccess:Bool = true
    
    init(
        model:RModel.Type,
        headers:[String:String]?,
        settingsId:SettingsId,
        method:Method,
        urlString:String,
        timeOut:TimeInterval = kTimeOut)
    {
        self.model = model
        self.headers = headers
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
    
    func request() -> URLRequest?
    {
        let urlRequest:NSMutableURLRequest
        
        #if DEBUG
            
            print(urlString)
            
        #endif
        
        guard
            
            let url:URL = URL(string:urlString)
        
        else
        {
            return nil
        }
        
        urlRequest = NSMutableURLRequest(
            url:url,
            cachePolicy:kCachePolicy,
            timeoutInterval:timeOut)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allowsCellularAccess = kCellularAccess
        
        if let headers:[String:String] = self.headers
        {
            let keys:[String] = Array(headers.keys)
            
            for key:String in keys
            {
                guard
                    
                    let header:String = headers[key]
                
                else
                {
                    continue
                }
                
                urlRequest.setValue(
                    header,
                    forHTTPHeaderField:key)
            }
        }
        
        return urlRequest as URLRequest
    }
}
