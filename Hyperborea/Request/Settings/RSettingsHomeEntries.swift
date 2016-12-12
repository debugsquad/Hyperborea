import Foundation

class RSettingsHomeEntries:RSettings
{
    private let kRegionQuery:String = "regions="
    
    init(wordId:String, region:String?)
    {
        let headers:[String:String] = RConfiguration.sharedInstance.credentials.current()
        let sourceLanguage:String = MSession.sharedInstance.language.code
        let baseUrl:String = RUrl.sharedInstance.urlFor(
            urlKey:RUrl.UrlKey.oxfordApi)
        let entriesUrl:String = RUrl.sharedInstance.urlFor(
            urlKey:RUrl.UrlKey.entries)
        var urlString:String = "\(baseUrl)/\(entriesUrl)/\(sourceLanguage)/\(wordId)"
        
        if let regionReceived:String = region
        {
            urlString += "/\(kRegionQuery)\(regionReceived)"
        }
        
        super.init(
            model:RModelHomeEntries.self,
            headers:headers,
            settingsId:RSettings.SettingsId.homeEntries,
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
