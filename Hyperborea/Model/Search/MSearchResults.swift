import UIKit

class MSearchResults
{
    let items:[MSearchResultsItem]
    private let kMarginHorizontal:CGFloat = 30
    private let kMarginVertical:CGFloat = 10
    private let kFontSize:CGFloat = 16
    private let kCellMaxWidth:CGFloat = 140
    private let kCellMaxHeight:CGFloat = 90
    private let kKeyResults:String = "results"
    
    init(
        json:Any,
        language:MLanguage)
    {
        guard
            
            let jsonMap:[String:Any] = json as? [String:Any],
            let jsonResults:[Any] = jsonMap[kKeyResults] as? [Any],
            let maxResults16:Int16 = MSession.sharedInstance.settings?.maxResults
            
        else
        {
            self.items = []
            
            return
        }
        
        let maxResults:Int = Int(maxResults16)
        var items:[MSearchResultsItem] = []
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:kFontSize),
            NSForegroundColorAttributeName:UIColor.black]
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
                    json:jsonResult,
                    language:language)
                
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
            
            if items.count > maxResults
            {
                break
            }
        }
        
        self.items = items
    }
}
