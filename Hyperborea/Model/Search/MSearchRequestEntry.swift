import Foundation

class MSearchRequestEntity:MSearchRequest
{
    private weak var controller:CSearch?
    private let kRegionQuery:String = "regions="
    private let kEmpty:String = ""
    
    @discardableResult init(
        controller:CSearch,
        wordId:String,
        word:String,
        languageRaw:Int16,
        region:String?)
    {
        super.init()
        self.controller = controller
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            self.asyncRequest(
                wordId:wordId,
                word:word,
                languageRaw:languageRaw,
                region:region)
        }
    }
    
    //MARK: private
    
    private func asyncRequest(
        wordId:String,
        word:String,
        languageRaw:Int16,
        region:String?)
    {
        let language:MLanguage = MLanguage.language(rawValue:languageRaw)
        let languageCode:String = language.code
        
        guard
            
            let urlHost:String = MSession.sharedInstance.modelUrls.urlHost(host:MUrls.Host.hostOxford),
            let urlEndPoint:String = MSession.sharedInstance.modelUrls.urlEnpoint(endPoint:MUrls.EndPoint.oxfordEntries)
            
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
                    word:word,
                    languageRaw:languageRaw,
                    region:region,
                    data:data)
                
                break
                
            default:
                
                entry = MSearchEntry(
                    wordId:wordId,
                    word:word,
                    languageRaw:languageRaw,
                    region:region)
                
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
        word:String,
        languageRaw:Int16,
        region:String?,
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
            word:word,
            languageRaw:languageRaw,
            region:region,
            json:json)
        
        return entry
    }
}
