import UIKit

class MSearchEntryTense
{
    private static let kBreak:String = "\n"
    private static let kSeparator:String = ", "
    private static let kKeyEntries:String = "entries"
    private static let kKeyGrammaticalFeatures:String = "grammaticalFeatures"
    private static let kKeyType:String = "type"
    private static let kKeyText:String = "text"
    private static let kTypeTense:String = "Tense"
    private static let kTypeNotFinite:String = "Non Finiteness"
    private static let kFontSize:CGFloat = 14
    
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
        let attributes:[String:Any] = [
            NSFontAttributeName:UIFont.regular(size:kFontSize)]
        let stringBreak:NSAttributedString = NSAttributedString(
            string:kBreak,
            attributes:attributes)
        let stringSeparator:NSAttributedString = NSAttributedString(
            string:kSeparator,
            attributes:attributes)
        
        for jsonEntry:Any in jsonEntries
        {
            guard
                
                let jsonEntryMap:[String:Any] = jsonEntry as? [String:Any],
                let jsonFeatures:[Any] = jsonEntryMap[kKeyGrammaticalFeatures] as? [Any]
                
            else
            {
                continue
            }
            
            for jsonFeature:Any in jsonFeatures
            {
                guard
                    
                    let featureMap:[String:Any] = jsonFeature as? [String:Any],
                    let featureMapType:String  = featureMap[kKeyType] as? String,
                    let featureMapText:String = featureMap[kKeyText] as? String
                    
                else
                {
                    continue
                }
                
                let tenseLowerCase:String = featureMapText.lowercased()
                let tenseString:NSAttributedString = NSAttributedString(
                    string:tenseLowerCase,
                    attributes:attributes)
                
                if featureMapType == kTypeTense
                {
                    if !mutableString.string.isEmpty
                    {
                        mutableString.insert(stringSeparator, at:0)
                    }
                    
                    mutableString.insert(tenseString, at:0)
                }
                else if featureMapType == kTypeNotFinite
                {
                    if !mutableString.string.isEmpty
                    {
                        mutableString.append(stringSeparator)
                    }
                    
                    mutableString.append(tenseString)
                }
            }
        }
        
        if !mutableString.string.isEmpty
        {
            mutableString.insert(stringBreak, at:0)
        }
        
        return mutableString
    }
}
