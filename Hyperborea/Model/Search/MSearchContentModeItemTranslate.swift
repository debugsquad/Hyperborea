import UIKit

class MSearchContentModeItemTranslate:MSearchContentModeItem
{
    private let kCellAddedHeight:CGFloat = 95
    
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
    
    override func usingString(controller:CSearch) -> NSAttributedString?
    {
        let attributedString:NSAttributedString? = controller.modelEntry?.translations?.attributedString
        
        return attributedString
    }
    
    override func contentHeight(controller:CSearch) -> CGFloat
    {
        let textHeight:CGFloat = heightForString(controller:controller)
        let cellHeight:CGFloat = textHeight + kCellAddedHeight
        
        return cellHeight
    }
}
