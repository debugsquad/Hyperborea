import Foundation

class MSearchRequestLook:MSearchRequest
{
    private weak var controller:CSearch?
    
    @discardableResult init(controller:CSearch, query:String)
    {
        super.init()
        self.controller = controller
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            self.asyncRequest(query:query)
        }
    }
    
    //MARK: private
    
    private func asyncRequest(query:String)
    {
        guard
            
            let urlHost:String = MSession.sharedInstance.modelUrls.urlHost(host:MUrls.Host.hostOxford),
            let urlEndPoint:String = MSession.sharedInstance.modelUrls.urlEnpoint(endPoint:MUrls.EndPoint.oxfordSearch),
            let languageCode:String = MSession.sharedInstance.settings?.languageCode()
        
        else
        {
            return
        }
        
        let urlString:String = "\(urlHost)/\(urlEndPoint)/\(languageCode)?q=\(query)"
        let headers:[String:String] = MSession.sharedInstance.modelOxfordCredentials.credentialHeaders()
        
        guard
        
            let request:URLRequest = request(
                urlString:urlString,
                headers:headers)
            
        else
        {
            return
        }
        
        task = session.dataTask(with:request)
        { (data:Data?, urlResponse:URLResponse?, error:Error?) in
            
            let statusCode:Int = self.statusCode(
                error:error,
                urlResponse:urlResponse)
            let results:MSearchResults?
            
            switch statusCode
            {
            case self.kStatusCodeSuccess:
                
                results = self.parseData(data:data)
                
                break
                
            default:
                
                results = nil
                
                break
            }
            
            guard
                
                let modelResults:MSearchResults = results
            
            else
            {
                return
            }
            
            self.controller?.resultsFound(
                query:query,
                modelResults:modelResults)
        }
        
        task?.resume()
        session.finishTasksAndInvalidate()
    }
    
    private func parseData(data:Data?) -> MSearchResults?
    {
        guard
            
            let dataStrong:Data = data
            
        else
        {
            return nil
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
            return nil
        }
        
        let results:MSearchResults = MSearchResults(
            json:json)
        
        return results
    }
}
