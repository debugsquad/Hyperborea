import UIKit

class MSearchContentModeItem
{
    let rawName:String
    let reusableIdentifier:String
    var attributedString:NSAttributedString?
    var cellWidth:CGFloat
    
    init(
        rawName:String,
        reusableIdentifier:String)
    {
        self.rawName = rawName
        self.reusableIdentifier = reusableIdentifier
        cellWidth = 0
    }
    
    //MARK: public
    
    func selected(controller:CSearch)
    {
    }
    
    func contentString(controller:CSearch) -> NSAttributedString?
    {
        return nil
    }
}
