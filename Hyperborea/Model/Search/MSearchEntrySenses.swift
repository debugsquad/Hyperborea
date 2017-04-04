import UIKit

class MSearchEntrySenses
{
    private static let kKeyEntries:String = "entries"
    private static let kKeySenses:String = "senses"
    private static let kKeyDefinitions:String = "definitions"
    private static let kKeyExamples:String = "examples"
    private static let kKeyExampleText:String = "text"
    private static let kKeySubsenses:String = "subsenses"
    private static let kSensesSeparator:String = "\n"
    private static let kExampleSeparator:String = "\n• "
    private static let kTitleFontSize:CGFloat = 18
    private static let kExampleFontSize:CGFloat = 16
    
    class func parse(json:Any) -> NSAttributedString?
    {
        guard
            
            let jsonMap:[String:Any] = json as? [String:Any],
            let jsonEntries:[Any] = jsonMap[kKeyEntries] as? [Any]
            
        else
        {
            return nil
        }
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
        for jsonEntry:Any in jsonEntries
        {
            guard
                
                let jsonEntryMap:[String:Any] = jsonEntry as? [String:Any],
                let jsonSenses:[Any] = jsonEntryMap[kKeySenses] as? [Any]
                
            else
            {
                continue
            }
            
            let attributesSeparator:[String:AnyObject] = [
                NSFontAttributeName:UIFont.regular(size:kTitleFontSize)]
            let stringSeparator:NSAttributedString = NSAttributedString(
                string:kSensesSeparator,
                attributes:attributesSeparator)
            
            mutableString.append(stringSeparator)
            
            for jsonSense:Any in jsonSenses
            {
                guard
                    
                    let jsonSenseMap:[String:Any] = jsonSense as? [String:Any]
                    
                else
                {
                    continue
                }
                
                if let senseString:NSAttributedString = parseItem(json:jsonSenseMap)
                {
                    mutableString.append(senseString)
                }
                
                if let jsonSubsenses:[Any] = jsonSenseMap[kKeySubsenses] as? [Any]
                {
                    for jsonSubsense:Any in jsonSubsenses
                    {
                        guard
                            
                            let jsonSubsenseMap:[String:Any] = jsonSubsense as? [String:Any]
                            
                        else
                        {
                            continue
                        }
                        
                        if let subSenseString:NSAttributedString = parseItem(json:jsonSubsenseMap)
                        {
                            mutableString.append(subSenseString)
                        }
                    }
                }
            }
        }
        
        return mutableString
    }
    
    private class func parseItem(json:[String:Any]) -> NSAttributedString?
    {
        var examples:[String] = []
        
        guard
        
            let titles:[String] = json[kKeyDefinitions] as? [String]
        
        else
        {
            return nil
        }
        
        if let sensesExamples:[Any] = json[kKeyExamples] as? [Any]
        {
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
        }
        
        let attributesTitle:[String:Any] = [
            NSFontAttributeName:UIFont.regular(size:kTitleFontSize)]
        let attributesExample:[String:Any] = [
            NSFontAttributeName:UIFont.regular(size:kExampleFontSize)]
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
        for title:String in titles
        {
            let separator:NSAttributedString = NSAttributedString(
                string:kSensesSeparator,
                attributes:attributesTitle)
            let titleString:NSAttributedString = NSAttributedString(
                string:title,
                attributes:attributesTitle)
            
            mutableString.append(separator)
            mutableString.append(titleString)
        }
        
        for example:String in examples
        {
            let separator:NSAttributedString = NSAttributedString(
                string:kExampleSeparator,
                attributes:attributesExample)
            let exampleString:NSAttributedString = NSAttributedString(
                string:example,
                attributes:attributesExample)
            
            mutableString.append(separator)
            mutableString.append(exampleString)
        }
        
        return mutableString
    }
}
