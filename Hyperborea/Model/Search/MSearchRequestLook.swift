import Foundation

class MSearchRequestLook
{
    private weak var controller:CSearch?
    
    private let kMethod:String = "GET"
    private let kNetworkServiceType:URLRequest.NetworkServiceType = URLRequest.NetworkServiceType.default
    private let kCachePolicy:URLRequest.CachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
    private let kResponseDisposition:URLSession.ResponseDisposition = URLSession.ResponseDisposition.allow
    private let kTimeOutData:TimeInterval = 15
    private let kCellularAccess:Bool = true
    private let kDiscretionary:Bool = true
    
    init(controller:CSearch, query:String)
    {
        self.controller = controller
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncLookQuery(query:query)
        }
    }
    
    //MARK: private
    
    private func asyncLookQuery(query:String)
    {
        let queryLowerCase:String = query.lowercased()
        
        let configuration:URLSessionConfiguration = URLSessionConfiguration.ephemeral
        configuration.allowsCellularAccess = kCellularAccess
        configuration.timeoutIntervalForRequest = kTimeOutData
        configuration.timeoutIntervalForResource = kTimeOutData
        configuration.isDiscretionary = kDiscretionary
        configuration.networkServiceType = kNetworkServiceType
        configuration.requestCachePolicy = kCachePolicy
        
        let urlString:String = kUrlString
        let urlMutableRequest:NSMutableURLRequest
        
        #if DEBUG
            
            print(urlString)
            
        #endif
        
        guard
            
            let url:URL = URL(string:urlString)
            
            else
        {
            return
        }
        
        urlMutableRequest = NSMutableURLRequest(
            url:url,
            cachePolicy:kCachePolicy,
            timeoutInterval:kTimeOutData)
        urlMutableRequest.httpMethod = kMethod
        urlMutableRequest.allowsCellularAccess = kCellularAccess
        
        let urlRequest:URLRequest = urlMutableRequest as URLRequest
        let urlSession:URLSession = URLSession(configuration:configuration)
        let task:URLSessionTask = urlSession.dataTask(with:urlRequest)
        { [weak self] (data:Data?, urlResponse:URLResponse?, error:Error?) in
            
            if let error:Error = error
            {
                self?.markersError(error:error.localizedDescription)
                
                return
            }
            
            guard
                
                let dataStrong:Data = data
                
                else
            {
                let error:String = NSLocalizedString("CRestaurantMarker_errorNoData", comment:"")
                self?.markersError(error:error)
                
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
                let error:String = NSLocalizedString("CRestaurantMarker_errorParsingJSON", comment:"")
                self?.markersError(error:error)
                
                return
            }
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
                { [weak self] in
                    
                    let model:MRestaurantMarker = MRestaurantMarker(json:json)
                    self?.loadMarkersImages(model:model)
            }
        }
        
        task.resume()
        urlSession.finishTasksAndInvalidate()
    }
}
