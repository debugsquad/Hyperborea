import UIKit

class MSearchContentModeItemDefinition:MSearchContentModeItem
{
    init()
    {
        let rawName:String = NSLocalizedString("MSearchContentModeItemDefinition_name", comment:"")
        let reusableIdentifier:String = VSearchContentCellDefinition.reusableIdentifier
        
        super.init(
            rawName:rawName,
            reusableIdentifier:reusableIdentifier)
    }
    
    override func contentString(modelEntry:MSearchEntry) -> NSAttributedString?
    {
        return modelEntry.attributedString
    }
}
