import UIKit

class RModelHomeEntriesSenses
{
    private let subsenses:[RModelHomeEntriesSensesSub]?
    private let title:String?
    private let examples:[String]?
    private let kKeySenses:String = "senses"
    private let kKeyDefinitions:String = "definitions"
    private let kKeyExamples:String = "examples"
    
    init(json:Any)
    {
        guard
        
            let jsonMap:[String:Any] = json as? [String:Any],
            let jsonSenses:[Any] = jsonMap[kKeySenses] as? [Any],
            let jsonSensesFirst:[String:Any] = jsonSenses.first as? [String:Any]
        
        else
        {
            subsenses = nil
            title = nil
            examples = nil
            
            return
        }
        
        if let sensesDefinitions:[String] = jsonSensesFirst[kKeyDefinitions] as? [String]
        {
            self.title = sensesDefinitions.first
        }
        else
        {
            self.title = nil
        }
    }
    
    //MARK: public
    
    func attributedString() -> NSAttributedString
    {
        
    }
}
