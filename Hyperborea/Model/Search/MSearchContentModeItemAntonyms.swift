import UIKit

class MSearchContentModeItemAntonyms:MSearchContentModeItem
{
    private let kCellAddedHeight:CGFloat = 40
    
    init()
    {
        let title:String = NSLocalizedString("MSearchContentModeItemAntonyms_title", comment:"")
        let symbol:String = NSLocalizedString("MSearchContentModeItemAntonyms_symbol", comment:"")
        let reusableIdentifier:String = VSearchContentCellAntonyms.reusableIdentifier
        
        super.init(
            title:title,
            symbol:symbol,
            reusableIdentifier:reusableIdentifier)
    }
    
    override func selected(controller:CSearch)
    {
        controller.fetchAntonyms()
    }
    
    override func contentHeight(controller:CSearch) -> CGFloat
    {
        guard
            
            let attributedString:NSAttributedString = controller.modelEntry?.attributedString
            
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
