import Foundation

class MSearchRequestEntity:MSearchRequest
{
    private weak var controller:CSearch?
    private let kRegionQuery:String = "regions="
    private let kEmpty:String = ""
    
    @discardableResult init(controller:CSearch, wordId:String, region:String?)
    {
        super.init()
        self.controller = controller
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            self.asyncRequest(wordId:wordId, region:region)
        }
    }
    
    //MARK: private
    
    private func asyncRequest(wordId:String, region:String?)
    {
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
            let entry:MSearchEntry?
            
            switch statusCode
            {
            case self.kStatusCodeSuccess:
                
                entry = self.parseData(
                    wordId:wordId,
                    data:data)
                
                break
                
            default:
                
                entry = MSearchEntry(wordId:wordId)
                
                break
            }
            
            guard
                
                let modelEntry:MSearchEntry = entry
            
            else
            {
                return
            }
            
            self.controller?.showContent(modelEntry:modelEntry)
        }
        
        task?.resume()
        session.finishTasksAndInvalidate()
    }
    
    private func parseData(
        wordId:String,
        data:Data?) -> MSearchEntry?
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
        
        let entry:MSearchEntry = MSearchEntry(
            wordId:wordId,
            json:json)
        
        return entry
    }
}
