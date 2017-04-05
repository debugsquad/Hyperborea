import UIKit

class MSearchContentModeItemTranslate:MSearchContentModeItem
{
    init()
    {
        let title:String = NSLocalizedString("MSearchContentModeItemTranslate_title", comment:"")
        let symbol:String = NSLocalizedString("MSearchContentModeItemTranslate_symbol", comment:"")
        let reusableIdentifier:String = VSearchContentCellTranslations.reusableIdentifier
        
        super.init(
            title:title,
            symbol:symbol,
            reusableIdentifier:reusableIdentifier)
    }
    
    override func selected(controller:CSearch)
    {
        controller.fetchTranslations()
    }
    /*
    override func contentString(controller:CSearch) -> CGFloat?
    {
        return controller.modelEntry?.translations?.attributedString
    }*/
}
