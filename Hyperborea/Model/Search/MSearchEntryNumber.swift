import UIKit

class MSearchEntryNumber
{
    private static let kKeyEntries:String = "entries"
    private static let kKeyGrammaticalFeatures:String = "grammaticalFeatures"
    private static let kKeyType:String = "type"
    private static let kKeyText:String = "text"
    private static let kTypeNumber:String = "Number"
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
        
        var numbers:[String] = []
        
        for jsonEntry:Any in jsonEntries
        {
            guard
                
                let jsonEntryMap:[String:Any] = jsonEntry as? [String:Any],
                let jsonFeatures:[Any] = jsonEntryMap[
                    kKeyGrammaticalFeatures] as? [Any]
                
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
                
                if featureMapType == kTypeNumber
                {
                    var append:Bool = true
                    
                    for number:String in numbers
                    {
                        if number == featureMapText
                        {
                            append = false
                            
                            break
                        }
                    }
                    
                    if append
                    {
                        numbers.append(featureMapText)
                    }
                }
            }
        }
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
        let attributes:[String:Any] = [
            NSFontAttributeName:UIFont.regular(size:kNumberFontSize)]
        let attributesSeparator:[String:Any] = [
            NSFontAttributeName:UIFont.regular(size:kSeparatorFontSize)]
        
        for number:String in numbers
        {
            let numberLowerCase:String = number.lowercased()
            
            if !mutableString.string.isEmpty
            {
                let separatorString:NSAttributedString = NSAttributedString(
                    string:kNumberSeparator,
                    attributes:attributesSeparator)
                
                mutableString.append(separatorString)
            }
            
            let numberString:NSAttributedString = NSAttributedString(
                string:numberLowerCase,
                attributes:attributes)
            
            mutableString.append(numberString)
        }
        
        return mutableString
    }
}
