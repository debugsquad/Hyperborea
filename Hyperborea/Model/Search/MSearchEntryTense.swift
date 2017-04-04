import UIKit

class MSearchEntryTense
{
    private static let kKeyEntries:String = "entries"
    private static let kKeyGrammaticalFeatures:String = "grammaticalFeatures"
    private static let kKeyType:String = "type"
    private static let kKeyText:String = "text"
    private static let kTypeTense:String = "Tense"
    private static let kTypeNotFinite:String = "Non Finiteness"
    private static let kGroupSeparator:String = "  "
    private static let kTenseSeparator:String = " | "
    private static let kFontSize:CGFloat = 15
    private static let kFontSizeSeparator:CGFloat = 12
    
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
        let attributesSeparator:[String:Any] = [
            NSFontAttributeName:UIFont.regular(size:kFontSizeSeparator)]
        
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
                
                let compositeString:String
                
                if mutableString.string.isEmpty
                {
                    compositeString = "\(kGroupSeparator)\(tenseLowerCase)"
                }
                else
                {
                    let separatorString:NSAttributedString = NSAttributedString(
                        string:kTenseSeparator,
                        attributes:attributesSeparator)
                    mutableString.append(separatorString)
                    
                    compositeString = tenseLowerCase
                }
                
                let tenseString:NSAttributedString = NSAttributedString(
                    string:compositeString,
                    attributes:attributes)
                
                if featureMapType == kTypeTense
                {
                    mutableString.insert(tenseString, at:0)
                }
                else if featureMapType == kTypeNotFinite
                {
                    mutableString.append(tenseString)
                }
            }
        }
        
        return mutableString
    }
}
