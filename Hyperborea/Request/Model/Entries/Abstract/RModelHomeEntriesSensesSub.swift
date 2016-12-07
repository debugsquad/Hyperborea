import UIKit

class RModelHomeEntriesSensesSub
{
    private let title:String?
    private let examples:[String]?
    private let kKeyDefinitions:String = "definitions"
    private let kKeyExamples:String = "examples"
    private let kKeyExampleText:String = "text"
    private let kSubsenseSeparator:String = "\n"
    private let kExampleSeparator:String = "\n○ "
    private let kTitleFontSize:CGFloat = 16
    private let kExampleFontSize:CGFloat = 14
    private let kTitleWhite:CGFloat = 0.6
    private let kExampleWhite:CGFloat = 0.7
    
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
                NSFontAttributeName:UIFont.regular(size:kTitleFontSize),
                NSForegroundColorAttributeName:UIColor(
                    white:kTitleWhite, alpha:1)
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
                NSFontAttributeName:UIFont.regular(size:kExampleFontSize),
                NSForegroundColorAttributeName:UIColor(
                    white:kExampleWhite, alpha:1)
            ]
            
            for example:String in examples
            {
                let exampleSeparator:String = "\(kExampleSeparator)\(example)"
                let exampleString:NSAttributedString = NSAttributedString(
                    string:exampleSeparator,
                    attributes:attributes)
                
                mutableString.append(exampleString)
            }
        }
        
        return mutableString
    }
}
