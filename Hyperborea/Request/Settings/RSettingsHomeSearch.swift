import Foundation

class RSettingsHomeSearch:RSettings
{
    private let kSourceLang:String = "en"
    private let kEmpty:String = ""
    private let kAppIdKey:String = "app_id"
    private let kAppKeyKey:String = "app_key"
    private let kAppIdValue:String = "c4753937"
    private let kAppKeyValue:String = "17a46e20204f62884100cc574e3ee824"
    
    init(text:String)
    {
        let headers:[String:String] = [
            kAppIdKey:kAppIdValue,
            kAppKeyKey:kAppKeyValue
        ]
        
        let baseUrl:String = RUrl.sharedInstance.urlFor(
            urlKey:RUrl.UrlKey.oxfordApi)
        let searchUrl:String = RUrl.sharedInstance.urlFor(
            urlKey:RUrl.UrlKey.search)
        let lowercaseText:String = text.lowercased()
        let query:String
        
        if let escapedLowercaseText:String = lowercaseText.addingPercentEncoding(
            withAllowedCharacters:CharacterSet.urlHostAllowed)
        {
            query = escapedLowercaseText
        }
        else
        {
            query = kEmpty
        }
        
        let urlString:String = "\(baseUrl)/\(searchUrl)/\(kSourceLang)?q=\(query)"
        
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
