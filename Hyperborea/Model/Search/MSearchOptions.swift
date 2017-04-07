import Foundation

class MSearchOptions
{
    let items:[MSearchOptionsItem]
    
    init()
    {
        let itemSettings:MSearchOptionsItemSettings = MSearchOptionsItemSettings()
        let itemStore:MSearchOptionsItemStore = MSearchOptionsItemStore()
        let itemFavorites:MSearchOptionsItemFavorites = MSearchOptionsItemFavorites()
        let itemRecent:MSearchOptionsItemRecent = MSearchOptionsItemRecent()
        
        items = [
            itemSettings,
            itemStore,
            itemFavorites,
            itemRecent]
    }
}
