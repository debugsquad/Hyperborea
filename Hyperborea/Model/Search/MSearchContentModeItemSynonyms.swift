import Foundation

class MSearchContentModeItemSynonyms:MSearchContentModeItem
{
    init()
    {
        let title:String = NSLocalizedString("MSearchContentModeItemSynonyms_title", comment:"")
        let symbol:String = NSLocalizedString("MSearchContentModeItemSynonyms_symbol", comment:"")
        let reusableIdentifier:String = VSearchContentCellSynonyms.reusableIdentifier
        
        super.init(
            title:title,
            symbol:symbol,
            reusableIdentifier:reusableIdentifier)
    }
    
    override func selected(controller:CSearch)
    {
        controller.fetchSynonyms()
    }
    
    override func contentString(controller:CSearch) -> NSAttributedString?
    {
        return controller.modelEntry?.synonyms?.attributedString
    }
}
