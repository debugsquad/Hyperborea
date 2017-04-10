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
    
    override func usingString(controller:CSearch) -> NSAttributedString?
    {
        let attributedString:NSAttributedString? = controller.modelEntry?.antonyms?.attributedString
        
        return attributedString
    }
    
    override func contentHeight(controller:CSearch) -> CGFloat
    {
        let textHeight:CGFloat = heightForString(controller:controller)
        var cellHeight:CGFloat = textHeight
        
        if textHeight > 0
        {
            cellHeight += kCellAddedHeight
        }
        
        return cellHeight
    }
}
