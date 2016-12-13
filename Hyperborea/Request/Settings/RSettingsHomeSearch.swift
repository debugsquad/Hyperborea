import Foundation

class RSettingsHomeSearch:RSettings
{
    private let kEmpty:String = ""
    
    init(text:String)
    {
        let headers:[String:String] = RConfiguration.sharedInstance.credentials.current()
        
        let baseUrl:String = RUrl.sharedInstance.urlFor(
            urlKey:RUrl.UrlKey.oxfordApi)
        let searchUrl:String = RUrl.sharedInstance.urlFor(
            urlKey:RUrl.UrlKey.search)
        let lowercaseText:String = text.lowercased()
        let query:String
        var urlString:String = kEmpty
        
        if let escapedLowercaseText:String = lowercaseText.addingPercentEncoding(
            withAllowedCharacters:CharacterSet.urlHostAllowed)
        {
            query = escapedLowercaseText
        }
        else
        {
            query = kEmpty
        }
        
        if let sourceLanguage:String = MSession.sharedInstance.language?.code
        {
            urlString = "\(baseUrl)/\(searchUrl)/\(sourceLanguage)?q=\(query)"
        }
        
        super.init(
            model:RModelHomeSearch.self,
            headers:headers,
            settingsId:RSettings.SettingsId.homeSearch,
            method:RSettings.Method.get,
            urlString:urlString)
    }
    
    override init(
        model:RModel.Type,
        headers:[String:String]?,
        settingsId:SettingsId,
        method:Method,
        urlString:String,
        timeOut:TimeInterval)
    {
        fatalError()
    }
    
    override init()
    {
        fatalError()
    }
}
