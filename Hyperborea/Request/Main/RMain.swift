import Foundation

class RMain:NSObject, URLSessionDelegate, URLSessionTaskDelegate, URLSessionDataDelegate
{
    private weak var delegate:RMainDelegate?
    private let settings:RSettings
    private var urlSession:URLSession?
    private var responseData:Data?
    private var responseError:Error?
    private var statusCode:Int?
    private let kNetworkServiceType:URLRequest.NetworkServiceType = URLRequest.NetworkServiceType.default
    private let kCachePolicy:URLRequest.CachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
    private let kCellularAccess:Bool = true
    private let kDiscretionary:Bool = true
    
    class func request(settings:RSettings, delegate:RMainDelegate?)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            let rMain:RMain = RMain(
                settings:settings,
                delegate:delegate)
        }
    }
    
    private init(settings:RSettings, delegate:RMainDelegate?)
    {
        self.delegate = delegate
        self.settings = settings
        
        makeRequest()
    }
    
    //MARK: Private
    
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
            rMain:self,
            error:error)
    }
    
    private func requestSuccess()
    {
        
    }
    
    //MARK: Public
    
    func cancelRequest()
    {
        invalidated = true
        urlSession?.invalidateAndCancel()
    }
    
    //MARK: session delegate
    
    func urlSession(_ session:URLSession, didBecomeInvalidWithError sessionError:Error?)
    {
        if !invalidated
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
                if responseData != nil
                {
                    do
                    {
                        response = try JSONSerialization.jsonObject(
                            with:responseData!,
                            options:JSONSerialization.ReadingOptions.allowFragments)
                    }
                    catch
                    {
                    }
                    
                    self.settings.parser.parse(rawJSON:response)
                }
                
                delegate?.requestSuccess(request:self)
            }
        }
    }
    
    //MARK: task delegate
    
    func urlSession(_ session:URLSession, task:URLSessionTask, didCompleteWithError error:Error?)
    {
        responseError = error
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
        let httpResponse:HTTPURLResponse = response as! HTTPURLResponse
        statusCode = httpResponse.statusCode
        completionHandler(Foundation.URLSession.ResponseDisposition.allow)
    }
}
