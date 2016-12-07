import Foundation

class RModelHomeEntriesItem
{
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
