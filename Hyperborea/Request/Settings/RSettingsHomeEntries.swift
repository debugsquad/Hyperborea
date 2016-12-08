import Foundation

class RSettingsHomeEntries:RSettings
{
    init(wordId:String)
    {
        let headers:[String:String] = RConfiguration.sharedInstance.credentials.current()
        let sourceLanguage:String = RConfiguration.sharedInstance.kSourceLang
        let baseUrl:String = RUrl.sharedInstance.urlFor(
            urlKey:RUrl.UrlKey.oxfordApi)
        let entriesUrl:String = RUrl.sharedInstance.urlFor(
            urlKey:RUrl.UrlKey.entries)
        let urlString:String = "\(baseUrl)/\(entriesUrl)/\(sourceLanguage)/\(wordId)"
        
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
