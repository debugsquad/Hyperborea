import Foundation

class MSearchOptions
{
    let items:[MSearchOptionsItem]
    
    init()
    {
        let itemSettings:MSearchOptionsItemSettings = MSearchOptionsItemSettings()
        let itemFavorites:MSearchOptionsItemFavorites = MSearchOptionsItemFavorites()
        let itemRecent:MSearchOptionsItemRecent = MSearchOptionsItemRecent()
        
        items = [
            itemSettings,
            itemFavorites,
            itemRecent]
    }
}
