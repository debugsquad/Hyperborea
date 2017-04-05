import UIKit

class MSearchContentModeItemAntonyms:MSearchContentModeItem
{
    init()
    {
        let rawName:String = NSLocalizedString("MSearchContentModeItemAntonyms_name", comment:"")
        let reusableIdentifier:String = VSearchContentCellAntonyms.reusableIdentifier
        
        super.init(
            rawName:rawName,
            reusableIdentifier:reusableIdentifier)
    }
    
    override func selected(controller:CSearch)
    {
        controller.fetchAntonyms()
    }
    
    override func contentString(controller:CSearch) -> NSAttributedString?
    {
        return controller.modelEntry?.synonyms?.attributedString
    }
}
