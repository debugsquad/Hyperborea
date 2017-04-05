import Foundation

class MSearchRequestTranslations:MSearchRequest
{
    private weak var controller:CSearch?
    private let kSuffix:String = "translations="
    
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
            let languageCode:String = MSession.sharedInstance.settings?.languageCode(),
            let translateTarget:String = MSession.sharedInstance.settings?.languageTranslate()
            
        else
        {
            return
        }
        
        let wordId:String = model.wordId
        let urlString:String = "\(urlHost)/\(urlEndPoint)/\(languageCode)/\(wordId)/\(kSuffix)\(translateTarget)"
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
            let modelTranslations:MSearchTranslations?
            
            switch statusCode
            {
            case self.kStatusCodeSuccess:
                
                modelTranslations = self.parseData(data:data)
                
                break
                
            default:
                
                modelTranslations = MSearchTranslations()
                
                break
            }
            
            model.translations = modelTranslations
            self.controller?.showContent(modelEntry:model)
        }
        
        task?.resume()
        session.finishTasksAndInvalidate()
    }
    
    private func parseData(data:Data?) -> MSearchTranslations?
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
        
        let modelTranslations:MSearchTranslations = MSearchTranslations(json:json)
        
        return modelTranslations
    }
}
