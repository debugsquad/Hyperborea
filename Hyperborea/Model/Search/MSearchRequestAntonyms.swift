import Foundation

class MSearchRequestAntonyms:MSearchRequest
{
    private weak var controller:CSearch?
    private let kSuffix:String = "antonyms"
    
    @discardableResult init(controller:CSearch, model:MSearchEntry)
    {
        super.init()
        self.controller = controller
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            self.asyncRequest(model:model)
        }
    }
    
    //MARK: private
    
    private func asyncRequest(model:MSearchEntry)
    {
        guard
            
            let urlHost:String = MSession.sharedInstance.modelUrls.urlHost(host:MUrls.Host.hostOxford),
            let urlEndPoint:String = MSession.sharedInstance.modelUrls.urlEnpoint(endPoint:MUrls.EndPoint.oxfordEntries),
            let languageCode:String = MSession.sharedInstance.settings?.languageCode()
            
        else
        {
            return
        }
        
        let wordId:String = model.wordId
        let urlString:String = "\(urlHost)/\(urlEndPoint)/\(languageCode)/\(wordId)/\(kSuffix)"
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
            let modelAntonyms:MSearchAntonyms?
            
            switch statusCode
            {
            case self.kStatusCodeSuccess:
                
                modelAntonyms = self.parseData(data:data)
                
                break
                
            default:
                
                modelAntonyms = MSearchAntonyms()
                
                break
            }
            
            model.antonyms = modelAntonyms
            self.controller?.showContent(modelEntry:model)
        }
        
        task?.resume()
        session.finishTasksAndInvalidate()
    }
    
    private func parseData(data:Data?) -> MSearchAntonyms?
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
                options:
                JSONSerialization.ReadingOptions.allowFragments)
        }
        catch
        {
            return nil
        }
        
        let modelAntonyms:MSearchAntonyms = MSearchAntonyms(json:json)
        
        return modelAntonyms
    }
}
