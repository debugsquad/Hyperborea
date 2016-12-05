import Foundation

class RMain:NSObject, URLSessionDelegate, URLSessionTaskDelegate, URLSessionDataDelegate
{
    private weak var delegate:RMainDelegate?
    let settings:RequestSettings
    var urlSession:Foundation.URLSession?
    var responseData:Data?
    var response:Any?
    var responseError:Error?
    var invalidated:Bool = false
    var statusCode:Int = 0
    
    class func request(settings:RequestSettings, delegate:RequestProtocol?) -> RequestManager
    {
        let requestManager:RequestManager = RequestManager(settings:settings, delegate:delegate)
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            {
                requestManager.makeRequest()
        }
        
        return requestManager
    }
    
    //MARK: Public
    
    func cancelRequest()
    {
        invalidated = true
        urlSession?.invalidateAndCancel()
    }
    
    //MARK: Private
    
    private init(settings:RequestSettings, delegate:RequestProtocol?)
    {
        self.settings = settings
        self.delegate = delegate
    }
    
    private func makeRequest()
    {
        let operation:OperationQueue = OperationQueue()
        let configuration:URLSessionConfiguration = URLSessionConfiguration.ephemeral
        let request:URLRequest = settings.type.urlRequest(settings:settings) as URLRequest
        configuration.allowsCellularAccess = true
        configuration.timeoutIntervalForRequest = settings.timeout
        configuration.timeoutIntervalForResource = settings.timeout
        configuration.isDiscretionary = true
        configuration.networkServiceType = NSURLRequest.NetworkServiceType.default
        configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        urlSession = Foundation.URLSession(configuration:configuration, delegate:self, delegateQueue:operation)
        
        let task:URLSessionTask = urlSession!.dataTask(with: request)
        task.resume()
        
        urlSession?.finishTasksAndInvalidate()
    }
    
    private func requestError(error:String)
    {
        delegate?.requestError(request:self, error:error)
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
