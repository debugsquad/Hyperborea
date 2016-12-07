import Foundation

class RModelHomeEntriesItem
{
    let attributedString:NSAttributedString
    let reusableIdentifier:String
    let selectable:Bool
    
    required init(json:Any)
    {
        fatalError()
    }
    
    init(
        attributedString:NSAttributedString,
        reusableIdentifier:String,
        selectable:Bool)
    {
        self.attributedString = attributedString
        self.reusableIdentifier = reusableIdentifier
        self.selectable = selectable
    }
}
