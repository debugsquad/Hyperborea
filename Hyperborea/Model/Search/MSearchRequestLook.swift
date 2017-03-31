import Foundation

class MSearchRequestLook
{
    private weak var controller:CSearch?
    private weak var task:URLSessionTask?
    private let kMethod:String = "GET"
    private let kNetworkServiceType:URLRequest.NetworkServiceType = URLRequest.NetworkServiceType.default
    private let kCachePolicy:URLRequest.CachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
    private let kResponseDisposition:URLSession.ResponseDisposition = URLSession.ResponseDisposition.allow
    private let kTimeOutData:TimeInterval = 15
    private let kCellularAccess:Bool = true
    private let kDiscretionary:Bool = true
    
    @discardableResult init(controller:CSearch, query:String)
    {
        self.controller = controller
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            self.asyncLookQuery(query:query)
        }
    }
    
    deinit
    {
        print("died request")
    }
    
    //MARK: private
    
    private func asyncLookQuery(query:String)
    {
        let queryLowerCase:String = query.lowercased()
        
        guard
            
            let urlHost:String = MSession.sharedInstance.modelUrls.urlHost(host:MUrls.Host.hostOxford),
            let urlEndPoint:String = MSession.sharedInstance.modelUrls.urlEnpoint(endPoint:MUrls.EndPoint.oxfordSearch),
            let languageCode:String = MSession.sharedInstance.settings?.languageCode(),
            let queryEscaped:String = queryLowerCase.addingPercentEncoding(
                withAllowedCharacters:CharacterSet.urlHostAllowed)
        
        else
        {
            return
        }
        
        let urlString:String = "\(urlHost)/\(urlEndPoint)/\(languageCode)?q=\(queryEscaped)"
        
        #if DEBUG
            
            print(urlString)
            
        #endif
        
        guard
            
            let url:URL = URL(string:urlString)
            
        else
        {
            return
        }
        
        let configuration:URLSessionConfiguration = URLSessionConfiguration.ephemeral
        configuration.allowsCellularAccess = kCellularAccess
        configuration.timeoutIntervalForRequest = kTimeOutData
        configuration.timeoutIntervalForResource = kTimeOutData
        configuration.isDiscretionary = kDiscretionary
        configuration.networkServiceType = kNetworkServiceType
        configuration.requestCachePolicy = kCachePolicy
        
        let headers:[String:String] = MSession.sharedInstance.modelOxfordCredentials.credentialHeaders()
        let urlMutableRequest:NSMutableURLRequest = NSMutableURLRequest(
            url:url,
            cachePolicy:kCachePolicy,
            timeoutInterval:kTimeOutData)
        urlMutableRequest.httpMethod = kMethod
        urlMutableRequest.allowsCellularAccess = kCellularAccess
        
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
        
        let urlRequest:URLRequest = urlMutableRequest as URLRequest
        
        let urlSession:URLSession = URLSession(configuration:configuration)
        task = urlSession.dataTask(with:urlRequest)
        { [weak self] (data:Data?, urlResponse:URLResponse?, error:Error?) in
            
            if error != nil
            {
                return
            }
            
            guard
                
                let dataStrong:Data = data
                
            else
            {
                return
            }
            
            let json:Any
            
            do
            {
                try json = JSONSerialization.jsonObject(
                    with:dataStrong,
                    options:JSONSerialization.ReadingOptions.allowFragments)
            }
            catch
            {
                return
            }
            
            print(json)
        }
        
        task?.resume()
        urlSession.finishTasksAndInvalidate()
    }
}
