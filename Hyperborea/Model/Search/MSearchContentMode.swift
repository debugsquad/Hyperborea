import UIKit

class MSearchContentMode
{
    let items:[MSearchContentModeItem]
    var selectedIndex:Int
    
    init()
    {
        let itemDefinition:MSearchContentModeItemDefinition = MSearchContentModeItemDefinition()
        let itemSynonyms:MSearchContentModeItemSynonyms = MSearchContentModeItemSynonyms()
        let itemAntonyms:MSearchContentModeItemAntonyms = MSearchContentModeItemAntonyms()
        let itemTranslate:MSearchContentModeItemTranslate = MSearchContentModeItemTranslate()
        let itemOrigins:MSearchContentModeItemOrigins = MSearchContentModeItemOrigins()
        
        items = [
            itemDefinition,
            itemSynonyms,
            itemAntonyms,
            itemTranslate,
            itemOrigins]
        
        selectedIndex = 0
    }
    
    //MARK: public
    
    func currentItem() -> MSearchContentModeItem
    {
        let item:MSearchContentModeItem = items[selectedIndex]
        
        return item
    }
}
