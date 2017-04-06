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
