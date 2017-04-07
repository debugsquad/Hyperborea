import Foundation

class MSettings
{
    let items:[MSettingsItem]
    
    init()
    {
        let itemLanguage:MSettingsItemLanguage = MSettingsItemLanguage()
        let itemResults:MSettingsItemResults = MSettingsItemResults()
        
        items = [
            itemLanguage,
            itemResults]
    }
}
