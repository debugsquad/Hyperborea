import Foundation

class MSettings
{
    let items:[MSettingsItem]
    
    init()
    {
        let itemLanguage:MSettingsItemLanguage = MSettingsItemLanguage()
        let itemResults:MSettingsItemResults = MSettingsItemResults()
        let itemRetina:MSettingsItemRetina = MSettingsItemRetina()
        
        items = [
            itemLanguage,
            itemResults,
            itemRetina]
    }
}
