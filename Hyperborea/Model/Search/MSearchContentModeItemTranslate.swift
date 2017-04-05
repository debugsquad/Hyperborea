import UIKit

class MSearchContentModeItemTranslate:MSearchContentModeItem
{
    init()
    {
        let rawName:String = NSLocalizedString("MSearchContentModeItemTranslate_name", comment:"")
        let reusableIdentifier:String = VSearchContentCellTranslations.reusableIdentifier
        
        super.init(
            rawName:rawName,
            reusableIdentifier:reusableIdentifier)
    }
    
    override func selected(controller:CSearch)
    {
        controller.fetchTranslations()
    }
    
    override func contentString(controller:CSearch) -> NSAttributedString?
    {
        return controller.modelEntry?.translations?.attributedString
    }
}
