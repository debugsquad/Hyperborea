import UIKit

class RModelHomeEntriesSensesSub
{
    private let title:String?
    private let examples:[String]?
    private let kKeyDefinitions:String = "definitions"
    private let kKeyExamples:String = "examples"
    private let kKeyExampleText:String = "text"
    
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
        
    }
}
