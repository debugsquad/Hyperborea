import UIKit

class MSearchEntryNumeral
{
    private static let kKeyEntries:String = "entries"
    private static let kKeyGrammaticalFeatures:String = "grammaticalFeatures"
    private static let kKeyType:String = "type"
    private static let kKeyText:String = "text"
    private static let kTypeNumeral:String = "Numeral"
    private static let kGroupSeparator:String = "  "
    private static let kNumberSeparator:String = " | "
    private static let kNumberFontSize:CGFloat = 15
    private static let kSeparatorFontSize:CGFloat = 14
    
    class func parse(json:Any) -> NSAttributedString?
    {
        guard
            
            let jsonMap:[String:Any] = json as? [String:Any],
            let jsonEntries:[Any] = jsonMap[kKeyEntries] as? [Any]
            
        else
        {
            return nil
        }
        
        var numerals:[String] = []
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        let attributes:[String:Any] = [
            NSFontAttributeName:UIFont.regular(size:kNumberFontSize)]
        let attributesSeparator:[String:Any] = [
            NSFontAttributeName:UIFont.regular(size:kSeparatorFontSize)]
        
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
                
                if featureMapType == kTypeNumeral
                {
                    let numeralLowerCase:String = featureMapText.lowercased()
                    var append:Bool = true
                    
                    for number:String in numerals
                    {
                        if number == numeralLowerCase
                        {
                            append = false
                            
                            break
                        }
                    }
                    
                    if append
                    {
                        numerals.append(numeralLowerCase)
                        
                        let compositeString:String
                        
                        if mutableString.string.isEmpty
                        {
                            compositeString = "\(kGroupSeparator)\(numeralLowerCase)"
                        }
                        else
                        {
                            let separatorString:NSAttributedString = NSAttributedString(
                                string:kNumberSeparator,
                                attributes:attributesSeparator)
                            mutableString.append(separatorString)
                            
                            compositeString = numeralLowerCase
                        }
                        
                        let numberString:NSAttributedString = NSAttributedString(
                            string:compositeString,
                            attributes:attributes)
                        
                        mutableString.append(numberString)
                    }
                }
            }
        }
        
        return mutableString
    }
}
