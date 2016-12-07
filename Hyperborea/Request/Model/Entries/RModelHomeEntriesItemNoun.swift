import Foundation

class RModelHomeEntriesItemNoun:RModelHomeEntriesItem
{
    private let kSelectable:Bool = false
    
    required init(json:Any)
    {
        let reusableIdentifier:String = 
        
        super.init(
            attributedString: <#T##NSAttributedString#>,
            reusableIdentifier: <#T##String#>,
            selectable:kSelectable)
    }
    
    override init(
        attributedString:NSAttributedString,
        reusableIdentifier:String,
        selectable:Bool)
    {
        fatalError()
    }
}
