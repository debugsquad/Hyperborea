import UIKit

class MSearchContentModeItemDefinition:MSearchContentModeItem
{
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
    
    override func contentHeight(controller: CSearch) -> CGFloat
    {
        let width:CGFloat = bounds.maxX
        let maxSize:CGSize = CGSize(
            width:width - kContentRemoveWidth,
            height:kCompareHeight)
        let boundingRect:CGRect = contentString.boundingRect(
            with:maxSize,
            options:drawingOptions,
            context:nil)
        let textHeight:CGFloat = ceil(boundingRect.size.height)
        cellHeight = textHeight + kContentAddHeight
    }
    /*
    override func contentString(controller:CSearch) -> CGFloat
    {
        return controller.modelEntry?.attributedString
        
        return 0
    }*/
}
