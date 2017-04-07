import UIKit

class MSearchContentModeItem
{
    let title:String
    let symbol:String
    let reusableIdentifier:String
    private let drawingOptions:NSStringDrawingOptions
    private let kContentRemoveWidth:CGFloat = 20
    private let kCompareHeight:CGFloat = 9000
    
    init(
        title:String,
        symbol:String,
        reusableIdentifier:String)
    {
        drawingOptions = NSStringDrawingOptions([
            NSStringDrawingOptions.usesFontLeading,
            NSStringDrawingOptions.usesLineFragmentOrigin])
        
        self.title = title
        self.symbol = symbol
        self.reusableIdentifier = reusableIdentifier
    }
    
    //MARK: public
    
    final func heightForString(controller:CSearch) -> CGFloat
    {
        guard
            
            let string:NSAttributedString = usingString(controller:controller)
        
        else
        {
            return 0
        }
        
        let width:CGFloat = controller.viewSearch.bounds.maxX
        let maxSize:CGSize = CGSize(
            width:width - kContentRemoveWidth,
            height:kCompareHeight)
        let boundingRect:CGRect = string.boundingRect(
            with:maxSize,
            options:drawingOptions,
            context:nil)
        let textHeight:CGFloat = ceil(boundingRect.size.height)
        
        return textHeight
    }
    
    func selected(controller:CSearch)
    {
    }
    
    func contentHeight(controller:CSearch) -> CGFloat
    {
        return 0
    }
    
    func usingString(controller:CSearch) -> NSAttributedString?
    {
        return nil
    }
}
