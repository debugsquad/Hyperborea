import Foundation

class MSettings
{
    let items:[MSettingsItem]
    
    init()
    {
        let itemLanguage:MSettingsItemLanguage = MSettingsItemLanguage()
        
        items = [
            itemLanguage]
    }
}
