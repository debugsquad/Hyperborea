import UIKit

class MSearchResults
{
    let items:[MSearchResultsItem]
    private let kMarginHorizontal:CGFloat = 38
    private let kFontSize:CGFloat = 15
    private let kCellMaxWidth:CGFloat = 250
    private let kCellMaxHeight:CGFloat = 30
    private let kCellCompareWidth:CGFloat = 1000
    private let kKeyResults:String = "results"
    
    init(json:Any)
    {
        guard
            
            let jsonMap:[String:Any] = json as? [String:Any],
            let jsonResults:[Any] = jsonMap[kKeyResults] as? [Any]
            
        else
        {
            self.items = []
            
            return
        }
        
        var items:[MSearchResultsItem] = []
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:kFontSize)]
        let maxSize:CGSize = CGSize(
            width:kCellCompareWidth,
            height:kCellMaxHeight)
        let drawingOptions:NSStringDrawingOptions = NSStringDrawingOptions([
            NSStringDrawingOptions.usesFontLeading,
            NSStringDrawingOptions.usesLineFragmentOrigin])
        
        for jsonResult:Any in jsonResults
        {
            guard
                
                let item:MSearchResultsItem = MSearchResultsItem(
                    json:jsonResult)
                
            else
            {
                continue
            }
            
            let attributedString:NSAttributedString = NSAttributedString(
                string:item.word,
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
            
            item.attributedString = attributedString
            item.cellWidth = cellWidth
            items.append(item)
        }
        
        self.items = items
    }
}
