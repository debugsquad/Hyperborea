import UIKit

class MSearchContentModeItemAntonyms:MSearchContentModeItem
{
    init()
    {
        let rawName:String = NSLocalizedString("MSearchContentModeItemAntonyms_name", comment:"")
        let reusableIdentifier:String = VSearchContentCellDefinition.reusableIdentifier
        
        super.init(
            rawName:rawName,
            reusableIdentifier:reusableIdentifier)
    }
}
