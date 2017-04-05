import UIKit

class MSearchContentModeItem
{
    let title:String
    let symbol:String
    let reusableIdentifier:String
    
    init(
        title:String,
        symbol:String,
        reusableIdentifier:String)
    {
        self.title = title
        self.symbol = symbol
        self.reusableIdentifier = reusableIdentifier
    }
    
    //MARK: public
    
    func selected(controller:CSearch)
    {
    }
    
    func contentHeight(controller:CSearch) -> CGFloat
    {
        return 0
    }
}
