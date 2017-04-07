import UIKit

class MSearchContentModeItemDefinition:MSearchContentModeItem
{
    private let kCellAddedHeight:CGFloat = 40
    
    init()
    {
        let title:String = NSLocalizedString("MSearchContentModeItemDefinition_title", comment:"")
        let symbol:String = NSLocalizedString("MSearchContentModeItemDefinition_symbol", comment:"")
        let reusableIdentifier:String = VSearchContentCellDefinition.reusableIdentifier
        
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
        let attributedString:NSAttributedString? = controller.modelEntry?.attributedString
        
        return attributedString
    }
    
    override func contentHeight(controller:CSearch) -> CGFloat
    {
        let textHeight:CGFloat = heightForString(controller:controller)
        let cellHeight:CGFloat = textHeight + kCellAddedHeight
        
        return cellHeight
    }
}
