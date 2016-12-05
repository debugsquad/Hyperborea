import Foundation

class RSettingsHomeSearch:RSettings
{
    private let kSourceLang:String = "en"
    private let kEmpty:String = ""
    
    init(text:String)
    {
        let headers:[String:String] = [:
        ]
        
        let baseUrl:String = RUrl.sharedInstance.urlFor(
            urlKey:RUrl.UrlKey.oxfordApi)
        let entriesUrl:String = RUrl.sharedInstance.urlFor(
            urlKey:RUrl.UrlKey.entries)
        let lowercaseText:String = text.lowercased()
        let entry:String
        
        if let escapedLowercaseText:String = lowercaseText.addingPercentEncoding(
            withAllowedCharacters:CharacterSet.urlHostAllowed)
        {
            entry = escapedLowercaseText
        }
        else
        {
            entry = kEmpty
        }
        
        let urlString:String = "\(baseUrl)/\(entriesUrl)/\(kSourceLang)/\(entry)"
        
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
