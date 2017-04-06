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
    
    final func heightForString(controller:CSearch, string:NSAttributedString) -> CGFloat
    {
        
    }
    
    func selected(controller:CSearch)
    {
    }
    
    func contentHeight(controller:CSearch) -> CGFloat
    {
        return 0
    }
}
