import UIKit

class RModelHomeEntriesSenses
{
    private let subsenses:[RModelHomeEntriesSensesSub]
    private let title:String?
    private let examples:[String]?
    private let kKeyEntries:String = "entries"
    private let kKeySenses:String = "senses"
    private let kKeyDefinitions:String = "definitions"
    private let kKeyExamples:String = "examples"
    private let kKeyExampleText:String = "text"
    private let kKeySubsenses:String = "subsenses"
    private let kSensesSeparator:String = "\n"
    private let kExampleSeparator:String = "\n• "
    
    init(json:Any)
    {
        var
        
        guard
        
            let jsonMap:[String:Any] = json as? [String:Any],
            let jsonEntries:[Any] = jsonMap[kKeyEntries] as? [Any]
        
        else
        {
            subsenses = nil
            title = nil
            examples = nil
            
            return
        }
        
        for jsonEntry:
        
        let jsonEntriesFirst:[String:Any] = jsonEntries.first as? [String:Any],
        let jsonSenses:[Any] = jsonEntriesFirst[kKeySenses] as? [Any],
        let jsonSensesFirst:[String:Any] = jsonSenses.first as? [String:Any]
        
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
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
        if let title:String = self.title
        {
            let attributes:[String:Any] = [
                NSFontAttributeName:UIFont.regular(
                    size:RModelHomeEntriesItem.kDefinitionFontSize),
                NSForegroundColorAttributeName:UIColor(
                    white:RModelHomeEntriesItem.kDefinitionWhite,
                    alpha:1)
            ]
            
            let titleSeparator:String = "\(kSensesSeparator)\(title)"
            let titleString:NSAttributedString = NSAttributedString(
                string:titleSeparator,
                attributes:attributes)
            
            mutableString.append(titleString)
        }
        
        if let examples:[String] = self.examples
        {
            let attributes:[String:Any] = [
                NSFontAttributeName:UIFont.italic(
                    size:RModelHomeEntriesItem.kExampleFontSize),
                NSForegroundColorAttributeName:UIColor(
                    white:RModelHomeEntriesItem.kExampleWhite,
                    alpha:1)
            ]
            
            let attributesSeparator:[String:Any] = [
                NSFontAttributeName:UIFont.regular(
                    size:RModelHomeEntriesItem.kSeparatorFontSize),
                NSForegroundColorAttributeName:UIColor(
                    white:RModelHomeEntriesItem.kSeparatorWhite,
                    alpha:1)
            ]
            
            for example:String in examples
            {
                let separatorString:NSAttributedString = NSAttributedString(
                    string:kExampleSeparator,
                    attributes:attributesSeparator)
                
                let exampleString:NSAttributedString = NSAttributedString(
                    string:example,
                    attributes:attributes)
                
                mutableString.append(separatorString)
                mutableString.append(exampleString)
            }
        }
        
        if let subsenses:[RModelHomeEntriesSensesSub] = subsenses
        {
            for subsense:RModelHomeEntriesSensesSub in subsenses
            {
                let senseString:NSAttributedString = subsense.attributedString()
                
                mutableString.append(senseString)
            }
        }
        
        return mutableString
    }
}
