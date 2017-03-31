import Foundation

class MSearchOptions
{
    let items:[MSearchOptionsItem]
    
    init()
    {
        let itemSettings:MSearchOptionsItemSettings = MSearchOptionsItemSettings()
        let itemFavorites:MSearchOptionsItemFavorites = MSearchOptionsItemFavorites()
        
        items = [
            itemSettings,
            itemFavorites]
    }
}
