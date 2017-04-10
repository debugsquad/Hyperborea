import Foundation

class MSettings
{
    let items:[MSettingsItem]
    
    init()
    {
        let itemLanguage:MSettingsItemLanguage = MSettingsItemLanguage()
        let itemResults:MSettingsItemResults = MSettingsItemResults()
        let itemRetina:MSettingsItemRetina = MSettingsItemRetina()
        let itemShare:MSettingsItemShare = MSettingsItemShare()
        let itemReview:MSettingsItemReview = MSettingsItemReview()
        
        items = [
            itemLanguage,
            itemResults,
            itemRetina,
            itemShare,
            itemReview]
    }
}
