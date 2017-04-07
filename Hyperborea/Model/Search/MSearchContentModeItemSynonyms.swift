import UIKit

class MSearchContentModeItemSynonyms:MSearchContentModeItem
{
    private let kCellAddedHeight:CGFloat = 40
    
    init()
    {
        let title:String = NSLocalizedString("MSearchContentModeItemSynonyms_title", comment:"")
        let symbol:String = NSLocalizedString("MSearchContentModeItemSynonyms_symbol", comment:"")
        let reusableIdentifier:String = VSearchContentCellSynonyms.reusableIdentifier
        
        super.init(
            title:title,
            symbol:symbol,
            reusableIdentifier:reusableIdentifier)
    }
    
    override func selected(controller:CSearch)
    {
        controller.fetchSynonyms()
    }
    
    override func usingString(controller:CSearch) -> NSAttributedString?
    {
        let attributedString:NSAttributedString? = controller.modelEntry?.synonyms?.attributedString
        
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
