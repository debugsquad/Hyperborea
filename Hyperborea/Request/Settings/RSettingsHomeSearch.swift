import Foundation

class RSettingsHomeSearch:RSettings
{
    init(text:String)
    {
        let headers:[String:String] = [:
        ]
        let urlString:String = ""
        
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
