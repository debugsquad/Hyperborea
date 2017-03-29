import UIKit

class MSearchResults
{
    let items:[MSearchResultsItem]
    private let kMarginHorizontal:CGFloat = 30
    private let kFontSize:CGFloat = 14
    private let kCellMaxWidth:CGFloat = 250
    private let kCellMaxHeight:CGFloat = 30
    private let kCellCompareWidth:CGFloat = 1000
    
    init()
    {
        let loremIpsum:String = "Lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"
        let loremArray:[String] = loremIpsum.components(separatedBy:"\n")
        var items:[MSearchResultsItem] = []
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:kFontSize)]
        let maxSize:CGSize = CGSize(
            width:kCellCompareWidth,
            height:kCellMaxHeight)
        let drawingOptions:NSStringDrawingOptions = NSStringDrawingOptions([
            NSStringDrawingOptions.usesFontLeading,
            NSStringDrawingOptions.usesLineFragmentOrigin])
        
        for loremItem:String in loremArray
        {
            let attributedString:NSAttributedString = NSAttributedString(
                string:loremItem,
                attributes:attributes)
            let stringRect:CGRect = attributedString.boundingRect(
                with:maxSize,
                options:drawingOptions,
                context:nil)
            let stringWidth:CGFloat = ceil(stringRect.size.width)
            var cellWidth:CGFloat = stringWidth + kMarginHorizontal
            
            if cellWidth > kCellMaxWidth
            {
                cellWidth = kCellMaxWidth
            }
            
            let item:MSearchResultsItem = MSearchResultsItem(
                name:attributedString,
                cellWidth:cellWidth)
            items.append(item)
        }
        
        self.items = items
    }
}
