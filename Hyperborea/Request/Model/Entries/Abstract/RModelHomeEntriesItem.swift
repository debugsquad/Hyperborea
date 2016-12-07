import UIKit

class RModelHomeEntriesItem
{
    static let kTitleFontSize:CGFloat = 16
    static let kTitleWhite:CGFloat = 0.2
    let attributedString:NSAttributedString
    let reusableIdentifier:String
    let selectable:Bool
    
    init(
        attributedString:NSAttributedString,
        reusableIdentifier:String,
        selectable:Bool)
    {
        self.attributedString = attributedString
        self.reusableIdentifier = reusableIdentifier
        self.selectable = selectable
    }
    
    required init(json:Any)
    {
        fatalError()
    }
}
