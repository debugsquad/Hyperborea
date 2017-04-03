import UIKit

class MSearchContentModeItemOrigins:MSearchContentModeItem
{
    init()
    {
        let rawName:String = NSLocalizedString("MSearchContentModeItemOrigins_name", comment:"")
        let reusableIdentifier:String = VSearchContentCellDefinition.reusableIdentifier
        
        super.init(
            rawName:rawName,
            reusableIdentifier:reusableIdentifier)
    }
}
