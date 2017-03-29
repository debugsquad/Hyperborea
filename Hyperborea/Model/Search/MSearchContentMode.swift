import UIKit

class MSearchContentMode
{
    let items:[MSearchContentModeItem]
    var selectedIndex:Int
    private let kMarginHorizontal:CGFloat = 15
    private let kFontSize:CGFloat = 14
    private let kMaxStringWidth:CGFloat = 320
    private let kMaxStringHeight:CGFloat = 25
    
    init()
    {
        let itemDefinition:MSearchContentModeItemDefinition = MSearchContentModeItemDefinition()
        
        items = [
            itemDefinition]
        selectedIndex = 0
        
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:kFontSize)]
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
}