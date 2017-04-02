import UIKit

class MSearchResults
{
    let items:[MSearchResultsItem]
    private let kMarginHorizontal:CGFloat = 30
    private let kMarginVertical:CGFloat = 16
    private let kFontSize:CGFloat = 15
    private let kCellMaxWidth:CGFloat = 220
    private let kCellMaxHeight:CGFloat = 90
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
            width:kCellMaxWidth,
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
            let stringHeight:CGFloat = ceil(stringRect.size.height)
            let cellWidth:CGFloat = stringWidth + kMarginHorizontal
            let cellHeight:CGFloat = stringHeight + kMarginVertical
            
            item.attributedString = attributedString
            item.cellWidth = cellWidth
            item.cellHeight = cellHeight
            items.append(item)
        }
        
        self.items = items
    }
}
