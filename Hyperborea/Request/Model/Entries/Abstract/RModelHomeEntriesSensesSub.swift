import UIKit

class RModelHomeEntriesSensesSub
{
    private let title:String?
    private let examples:[String]?
    private let kKeyDefinitions:String = "definitions"
    private let kKeyExamples:String = "examples"
    private let kKeyExampleText:String = "text"
    private let kSubsenseSeparator:String = "\n\n"
    private let kExampleSeparator:String = "\n• "
    
    init(json:Any)
    {
        guard
        
            let jsonMap:[String:Any] = json as? [String:Any]
        
        else
        {
            title = nil
            examples = nil
            
            return
        }
        
        if let jsonDefinitions:[String] = jsonMap[kKeyDefinitions] as? [String]
        {
            self.title = jsonDefinitions.first
        }
        else
        {
            self.title = nil
        }
        
        if let jsonExamples:[Any] = jsonMap[kKeyExamples] as? [Any]
        {
            var examples:[String] = []
            
            for jsonExample:Any in jsonExamples
            {
                guard
                    
                    let exampleMap:[String:Any] = jsonExample as? [String:Any],
                    let exampleText:String = exampleMap[kKeyExampleText] as? String
                    
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
            
            let titleSeparator:String = "\(kSubsenseSeparator)\(title)"
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
        
        return mutableString
    }
}
