import Foundation

class RMain:NSObject, URLSessionDelegate, URLSessionTaskDelegate, URLSessionDataDelegate
{
    typealias StatusCode = Int
    
    private weak var delegate:RMainDelegate?
    private let settings:RSettings
    private var urlSession:URLSession?
    private var responseData:Data?
    private var responseError:Error?
    private var statusCode:StatusCode?
    private let kNetworkServiceType:URLRequest.NetworkServiceType = URLRequest.NetworkServiceType.default
    private let kCachePolicy:URLRequest.CachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
    private let kResponseDisposition:URLSession.ResponseDisposition = URLSession.ResponseDisposition.allow
    private let kCellularAccess:Bool = true
    private let kDiscretionary:Bool = true
    
    class func request(settings:RSettings, delegate:RMainDelegate?)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            let _:RMain = RMain(
                settings:settings,
                delegate:delegate)
        }
    }
    
    private init(settings:RSettings, delegate:RMainDelegate?)
    {
        self.delegate = delegate
        self.settings = settings
        super.init()
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedRequestCancel(sender:)),
            name:Notification.requestCancel,
            object:nil)
        
        makeRequest()
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: notified
    
    func notifiedRequestCancel(sender notification:Notification)
    {
        urlSession?.invalidateAndCancel()
    }
    
    //MARK: private
    
    private func makeRequest()
    {
        let operation:OperationQueue = OperationQueue()
        let configuration:URLSessionConfiguration = URLSessionConfiguration.ephemeral
        
        guard
            
            let request:URLRequest = settings.request()
        
        else
        {
            return
        }
        
        configuration.allowsCellularAccess = kCellularAccess
        configuration.timeoutIntervalForRequest = settings.timeOut
        configuration.timeoutIntervalForResource = settings.timeOut
        configuration.isDiscretionary = kDiscretionary
        configuration.networkServiceType = kNetworkServiceType
        configuration.requestCachePolicy = kCachePolicy
        
        urlSession = URLSession(
            configuration:configuration,
            delegate:self,
            delegateQueue:operation)
        
        let task:URLSessionTask? = urlSession?.dataTask(with:request)
        task?.resume()
        
        urlSession?.finishTasksAndInvalidate()
    }
    
    private func requestError(error:String)
    {
        delegate?.requestFinished(
            model:nil,
            status:statusCode,
            error:error)
    }
    
    private func requestSuccess(model:RModel?)
    {
        delegate?.requestFinished(
            model:model,
            status:statusCode,
            error:nil)
    }
    
    //MARK: session delegate
    
    func urlSession(_ session:URLSession, didBecomeInvalidWithError sessionError:Error?)
    {
        if responseError == nil
        {
            responseError = sessionError
        }
        
        if responseError != nil
        {
            requestError(error:responseError!.localizedDescription)
        }
        else
        {
            let model:RModel?
            
            if let responseData:Data = self.responseData
            {
                let response:Any?
                
                do
                {
                    response = try JSONSerialization.jsonObject(
                        with:responseData,
                        options:JSONSerialization.ReadingOptions.allowFragments)
                }
                catch
                {
                    response = nil
                }
                
                if let json:Any = response
                {
                    model = settings.model.init(json:json)
                }
                else
                {
                    model = nil
                }
            }
            else
            {
                model = nil
            }
            
            requestSuccess(model:model)
        }
    }
    
    //MARK: task delegate
    
    func urlSession(_ session:URLSession, task:URLSessionTask, didCompleteWithError error:Error?)
    {
        responseError = error
        responseData = nil
    }
    
    func urlSession(_ session:URLSession, dataTask:URLSessionDataTask, didReceive data:Data)
    {
        if responseData == nil
        {
            responseData = Data()
        }
        
        responseData?.append(data)
    }
    
    func urlSession(_ session:URLSession, dataTask:URLSessionDataTask, didReceive response:URLResponse, completionHandler:@escaping(URLSession.ResponseDisposition) -> ())
    {
        if let httpResponse:HTTPURLResponse = response as? HTTPURLResponse
        {
            statusCode = httpResponse.statusCode
        }

        completionHandler(kResponseDisposition)
    }
}