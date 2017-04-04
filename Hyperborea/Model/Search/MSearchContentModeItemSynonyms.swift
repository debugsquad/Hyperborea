import UIKit

class MSearchContentModeItemSynonyms:MSearchContentModeItem
{
    init()
    {
        let rawName:String = NSLocalizedString("MSearchContentModeItemSynonyms_name", comment:"")
        let reusableIdentifier:String = VSearchContentCellSynonyms.reusableIdentifier
        
        super.init(
            rawName:rawName,
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
