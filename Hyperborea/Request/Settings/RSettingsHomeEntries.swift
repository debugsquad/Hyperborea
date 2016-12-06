import Foundation

class RSettingsHomeEntries:RSettings
{
    private let kEmpty:String = ""
    
    init(wordId:String)
    {
        let headers:[String:String] = RConfiguration.sharedInstance.credentials.current()
        let sourceLanguage:String = RConfiguration.sharedInstance.kSourceLang
        let baseUrl:String = RUrl.sharedInstance.urlFor(
            urlKey:RUrl.UrlKey.oxfordApi)
        let entriesUrl:String = RUrl.sharedInstance.urlFor(
            urlKey:RUrl.UrlKey.entries)
        let lowercaseWordId:String = wordId.lowercased()
        let escapedWordId:String
        
        if let escapedLowercaseText:String = lowercaseWordId.addingPercentEncoding(
            withAllowedCharacters:CharacterSet.urlHostAllowed)
        {
            escapedWordId = escapedLowercaseText
        }
        else
        {
            escapedWordId = kEmpty
        }
        
        let urlString:String = "\(baseUrl)/\(entriesUrl)/\(sourceLanguage)/\(escapedWordId)"
        
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
