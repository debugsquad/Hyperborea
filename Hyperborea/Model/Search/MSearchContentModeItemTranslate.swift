import UIKit

class MSearchContentModeItemTranslate:MSearchContentModeItem
{
    init()
    {
        let rawName:String = NSLocalizedString("MSearchContentModeItemTranslate_name", comment:"")
        let reusableIdentifier:String = VSearchContentCellDefinition.reusableIdentifier
        
        super.init(
            rawName:rawName,
            reusableIdentifier:reusableIdentifier)
    }
}
