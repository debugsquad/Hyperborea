import Foundation

class MSearchContentModeItemOrigins:MSearchContentModeItem
{
    init()
    {
        let title:String = NSLocalizedString("MSearchContentModeItemOrigins_title", comment:"")
        let symbol:String = NSLocalizedString("MSearchContentModeItemOrigins_symbol", comment:"")
        let reusableIdentifier:String = VSearchContentCellDefinition.reusableIdentifier
        
        super.init(
            title:title,
            symbol:symbol,
            reusableIdentifier:reusableIdentifier)
    }
}
