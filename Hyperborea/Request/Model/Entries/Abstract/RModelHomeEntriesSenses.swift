import UIKit

class RModelHomeEntriesSenses
{
    private let subsenses:[RModelHomeEntriesSensesSub]?
    private let title:String?
    private let examples:[String]?
    private let kKeySenses:String = "senses"
    private let kKeyDefinitions:String = "definitions"
    private let kKeyExamples:String = "examples"
    private let kKeyExampleText:String = "text"
    private let kKeySubsenses:String = "subsenses"
    
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
        
        if let sensesExamples:[Any] = jsonSensesFirst[kKeyExamples] as? [Any]
        {
            var examples:[String] = []
            
            for sensesExample:Any in sensesExamples
            {
                guard
                
                    let sensesExampleMap:[String:Any] = sensesExample as? [String:Any],
                    let exampleText:String = sensesExampleMap[kKeyExampleText] as? String
                
                else
                {
                    continue
                }
                
                examples.append(exampleText)
            }
            
            self.examples = examples
        }
        else
        {
            self.examples = nil
        }
        
        if let jsonSubsenses:[Any] = jsonSensesFirst[kKeySubsenses] as? [Any]
        {
            var subsenses:[RModelHomeEntriesSensesSub] = []
            
            for jsonSubsense:Any in jsonSubsenses
            {
                let subsense:RModelHomeEntriesSensesSub = RModelHomeEntriesSensesSub(json:jsonSubsense)
                subsenses.append(subsense)
            }
            
            self.subsenses = subsenses
        }
        else
        {
            self.subsenses = nil
        }
    }
    
    //MARK: public
    
    func attributedString() -> NSAttributedString
    {
        
    }
}
