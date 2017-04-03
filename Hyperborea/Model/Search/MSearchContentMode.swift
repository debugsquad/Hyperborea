import UIKit

class MSearchContentMode
{
    let items:[MSearchContentModeItem]
    var selectedIndex:Int
    private let kMarginHorizontal:CGFloat = 20
    private let kFontSize:CGFloat = 16
    private let kMaxStringWidth:CGFloat = 320
    private let kMaxStringHeight:CGFloat = 25
    
    init()
    {
        let itemDefinition:MSearchContentModeItemDefinition = MSearchContentModeItemDefinition()
        let itemSynonyms:MSearchContentModeItemSynonyms = MSearchContentModeItemSynonyms()
        let itemAntonyms:MSearchContentModeItemAntonyms = MSearchContentModeItemAntonyms()
        let itemTranslate:MSearchContentModeItemTranslate = MSearchContentModeItemTranslate()
        let itemExamples:MSearchContentModeItemExamples = MSearchContentModeItemExamples()
        let itemOrigins:MSearchContentModeItemOrigins = MSearchContentModeItemOrigins()
        
        items = [
            itemDefinition,
            itemSynonyms,
            itemAntonyms,
            itemTranslate,
            itemExamples,
            itemOrigins]
        
        selectedIndex = 0
        
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bolder(size:kFontSize)]
        let maxStringSize:CGSize = CGSize(
            width:kMaxStringWidth,
            height:kMaxStringHeight)
        let drawingOptions:NSStringDrawingOptions = NSStringDrawingOptions([
            NSStringDrawingOptions.usesLineFragmentOrigin,
            NSStringDrawingOptions.usesFontLeading])
        
        for item:MSearchContentModeItem in items
        {
            let attributedString:NSAttributedString = NSAttributedString(
                string:item.rawName,
                attributes:attributes)
            let stringRect:CGRect = attributedString.boundingRect(
                with:maxStringSize,
                options:drawingOptions,
                context:nil)
            let rectWidth:CGFloat = ceil(stringRect.size.width)
            let cellWidth:CGFloat = rectWidth + kMarginHorizontal
            
            item.attributedString = attributedString
            item.cellWidth = cellWidth
        }
    }
    
    //MARK: public
    
    func reusableIdentifier() -> String
    {
        
    }
}
