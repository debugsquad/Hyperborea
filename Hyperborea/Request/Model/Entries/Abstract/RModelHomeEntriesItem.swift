import UIKit

class RModelHomeEntriesItem
{
    static let kTitleFontSize:CGFloat = 20
    static let kDefinitionFontSize:CGFloat = 17
    static let kExampleFontSize:CGFloat = 17
    static let kTitleWhite:CGFloat = 0
    static let kDefinitionWhite:CGFloat = 0.3
    static let kExampleWhite:CGFloat = 0.4
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
