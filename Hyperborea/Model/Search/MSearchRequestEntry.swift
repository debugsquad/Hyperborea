import Foundation

class MSearchRequestEntity
{
    private weak var controller:CSearch?
    private weak var task:URLSessionTask?
    private let kMethod:String = "GET"
    private let kRegionQuery:String = "regions="
    private let kEmpty:String = ""
    private let kNetworkServiceType:URLRequest.NetworkServiceType = URLRequest.NetworkServiceType.default
    private let kCachePolicy:URLRequest.CachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
    private let kResponseDisposition:URLSession.ResponseDisposition = URLSession.ResponseDisposition.allow
    private let kTimeOutData:TimeInterval = 15
    private let kCellularAccess:Bool = true
    private let kDiscretionary:Bool = true
    
    @discardableResult init(controller:CSearch, wordId:String, region:String?)
    {
        self.controller = controller
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            {
                self.asyncLookQuery(wordId:wordId, region:region)
        }
    }
    
    //MARK: private
    
    private func asyncLookQuery(wordId:String, region:String?)
    {
        /*
         
         let headers:[String:String] = RConfiguration.sharedInstance.credentials.current()
         let baseUrl:String = RUrl.sharedInstance.urlFor(
         urlKey:RUrl.UrlKey.oxfordApi)
         let entriesUrl:String = RUrl.sharedInstance.urlFor(
         urlKey:RUrl.UrlKey.entries)
         var urlString:String = kEmpty
         
         if let sourceLanguage:String = MSession.sharedInstance.language?.code
         {
         urlString = "\(baseUrl)/\(entriesUrl)/\(sourceLanguage)/\(wordId)"
         
         if let regionReceived:String = region
         {
         urlString += "/\(kRegionQuery)\(regionReceived)"
         }
         }
         
         super.init(
         model:RModelHomeEntries.self,
         headers:headers,
         settingsId:RSettings.SettingsId.homeEntries,
         method:RSettings.Method.get,
         urlString:urlString)
         
         */
        
        guard
            
            let urlHost:String = MSession.sharedInstance.modelUrls.urlHost(host:MUrls.Host.hostOxford),
            let urlEndPoint:String = MSession.sharedInstance.modelUrls.urlEnpoint(endPoint:MUrls.EndPoint.oxfordEntries),
            let languageCode:String = MSession.sharedInstance.settings?.languageCode()
            
        else
        {
            return
        }
        
        let regionString:String
        
        if let region:String = region
        {
            regionString = "/\(kRegionQuery)\(region)"
        }
        else
        {
            regionString = kEmpty
        }
        
        let urlString:String = "\(urlHost)/\(urlEndPoint)/\(languageCode)/\(wordId)\(regionString)"
        
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
        { [weak controller] (data:Data?, urlResponse:URLResponse?, error:Error?) in
            
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
            
            print("\(json)")
        }
        
        task?.resume()
        urlSession.finishTasksAndInvalidate()
    }
}
