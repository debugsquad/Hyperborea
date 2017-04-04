import UIKit

class MSearchEntrySenses
{
    private static let kBreak:String = "\n"
    private static let kBreakExample:String = "\n- "
    private static let kKeyEntries:String = "entries"
    private static let kKeySenses:String = "senses"
    private static let kKeyDefinitions:String = "definitions"
    private static let kKeyCrossReference:String = "crossReferenceMarkers"
    private static let kKeyExamples:String = "examples"
    private static let kKeyExampleText:String = "text"
    private static let kKeySubsenses:String = "subsenses"
    private static let kTitleFontSize:CGFloat = 18
    private static let kExampleFontSize:CGFloat = 15
    
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
        let attributesBreak:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:kTitleFontSize)]
        let stringBreak:NSAttributedString = NSAttributedString(
            string:kBreak,
            attributes:attributesBreak)
        
        for jsonEntry:Any in jsonEntries
        {
            guard
                
                let jsonEntryMap:[String:Any] = jsonEntry as? [String:Any],
                let jsonSenses:[Any] = jsonEntryMap[kKeySenses] as? [Any]
                
            else
            {
                continue
            }
            
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
                    if !mutableString.string.isEmpty
                    {
                        mutableString.append(stringBreak)
                    }
                    
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
                            if !mutableString.string.isEmpty
                            {
                                mutableString.append(stringBreak)
                            }
                            
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
        let attributesTitle:[String:Any] = [
            NSFontAttributeName:UIFont.regular(size:kTitleFontSize)]
        let attributesExample:[String:Any] = [
            NSFontAttributeName:UIFont.italic(size:kExampleFontSize),
            NSForegroundColorAttributeName:UIColor(white:0.5, alpha:1)]
        let stringBreak:NSAttributedString = NSAttributedString(
            string:kBreak,
            attributes:attributesTitle)
        let stringBreakExample:NSAttributedString = NSAttributedString(
            string:kBreakExample,
            attributes:attributesExample)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
        if let sensesTitles:[String] = json[kKeyDefinitions] as? [String]
        {
            for sensesTitle:String in sensesTitles
            {
                let titleString:NSAttributedString = NSAttributedString(
                    string:sensesTitle,
                    attributes:attributesTitle)
                
                mutableString.append(stringBreak)
                mutableString.append(titleString)
            }
        }
        
        if let sensesCrossReference:[String] = json[kKeyCrossReference] as? [String]
        {
            for crossReference:String in sensesCrossReference
            {
                let referenceString:NSAttributedString = NSAttributedString(
                    string:crossReference,
                    attributes:attributesTitle)
                
                mutableString.append(stringBreak)
                mutableString.append(referenceString)
            }
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
                
                let exampleString:NSAttributedString = NSAttributedString(
                    string:exampleText,
                    attributes:attributesExample)
                
                mutableString.append(stringBreakExample)
                mutableString.append(exampleString)
            }
        }
        
        return mutableString
    }
}
