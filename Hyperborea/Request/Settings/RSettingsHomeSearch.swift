import Foundation

class RSettingsHomeSearch:RSettings
{
    override init()
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
}
