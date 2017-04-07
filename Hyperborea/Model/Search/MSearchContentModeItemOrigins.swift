import UIKit

class MSearchContentModeItemOrigins:MSearchContentModeItem
{
    private let kCellAddedHeight:CGFloat = 40
    
    init()
    {
        let title:String = NSLocalizedString("MSearchContentModeItemOrigins_title", comment:"")
        let symbol:String = NSLocalizedString("MSearchContentModeItemOrigins_symbol", comment:"")
        let reusableIdentifier:String = VSearchContentCellOrigins.reusableIdentifier
        
        super.init(
            title:title,
            symbol:symbol,
            reusableIdentifier:reusableIdentifier)
    }
    
    override func selected(controller:CSearch)
    {
        if let modelEntry:MSearchEntry = controller.modelEntry
        {
            controller.showContent(modelEntry:modelEntry)
        }
    }
    
    override func usingString(controller:CSearch) -> NSAttributedString?
    {
        let attributedString:NSAttributedString? = controller.modelEntry?.origins.attributedString
        
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
