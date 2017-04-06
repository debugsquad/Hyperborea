import UIKit

class MSearchContentModeItemTranslate:MSearchContentModeItem
{
    private let kCellAddedHeight:CGFloat = 40
    
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
    
    override func contentHeight(controller:CSearch) -> CGFloat
    {
        guard
            
            let attributedString:NSAttributedString = controller.modelEntry?.translations?.attributedString
            
            else
        {
            return 0
        }
        
        let textHeight:CGFloat = heightForString(
            controller:controller,
            string:attributedString)
        let cellHeight:CGFloat = textHeight + kCellAddedHeight
        
        return cellHeight
    }
}
