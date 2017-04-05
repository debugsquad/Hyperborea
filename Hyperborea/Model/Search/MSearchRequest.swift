import Foundation

class MSearchRequest
{
    weak var task:URLSessionTask?
    let session:URLSession
    let kMethod:String = "GET"
    let kEmpty:String = ""
    let kNetworkServiceType:URLRequest.NetworkServiceType = URLRequest.NetworkServiceType.default
    let kCachePolicy:URLRequest.CachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
    let kResponseDisposition:URLSession.ResponseDisposition = URLSession.ResponseDisposition.allow
    let kTimeOutData:TimeInterval = 15
    let kCellularAccess:Bool = true
    let kDiscretionary:Bool = true
    let kStatusCodeSuccess:Int = 200
    let kStatusCodeError:Int = 0
    
    @discardableResult init()
    {
        let configuration:URLSessionConfiguration = URLSessionConfiguration.ephemeral
        configuration.allowsCellularAccess = kCellularAccess
        configuration.timeoutIntervalForRequest = kTimeOutData
        configuration.timeoutIntervalForResource = kTimeOutData
        configuration.isDiscretionary = kDiscretionary
        configuration.networkServiceType = kNetworkServiceType
        configuration.requestCachePolicy = kCachePolicy
        session = URLSession(configuration:configuration)
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(self.notifiedCancelRequests(sender:)),
            name:Notification.cancelRequests,
            object:nil)
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: notified
    
    @objc func notifiedCancelRequests(sender notification:Notification)
    {
        print("stopped")
        
        task?.cancel()
    }
    
    //MARK: public
    
    final func request(urlString:String, headers:[String:String]?) -> URLRequest?
    {
        #if DEBUG
            
            print(urlString)
            
        #endif
        
        guard
            
            let url:URL = URL(string:urlString)
            
        else
        {
            return nil
        }
        
        let urlMutableRequest:NSMutableURLRequest = NSMutableURLRequest(
            url:url,
            cachePolicy:kCachePolicy,
            timeoutInterval:kTimeOutData)
        urlMutableRequest.httpMethod = kMethod
        urlMutableRequest.allowsCellularAccess = kCellularAccess
        
        if let headers:[String:String] = headers
        {
            let headersKeys:[String] = Array(headers.keys)
            
            for key:String in headersKeys
            {
                guard
                    
                    let header:String = headers[key]
                    
                else
                {
                    continue
                }
                
                urlMutableRequest.setValue(
                    header,
                    forHTTPHeaderField:key)
            }
        }
        
        let urlRequest:URLRequest = urlMutableRequest as URLRequest
        
        return urlRequest
    }
    
    final func statusCode(urlResponse:URLResponse?) -> Int
    {
        guard
            
            let response:HTTPURLResponse = urlResponse as? HTTPURLResponse
            
        else
        {
            return kStatusCodeError
        }
        
        return response.statusCode
    }
}
