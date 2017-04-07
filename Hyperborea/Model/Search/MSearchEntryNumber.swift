import UIKit

class MSearchEntryNumber
{
    private static let kBreak:String = "\n"
    private static let kSeparator:String = ", "
    private static let kKeyEntries:String = "entries"
    private static let kKeyGrammaticalFeatures:String = "grammaticalFeatures"
    private static let kKeyType:String = "type"
    private static let kKeyText:String = "text"
    private static let kTypeNumber:String = "Number"
    private static let kNumberFontSize:CGFloat = 14
    
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
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:kNumberFontSize)]
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
                    let numberLowerCase:String = featureMapText.lowercased()
                    var append:Bool = true
                    
                    for number:String in numbers
                    {
                        if number == numberLowerCase
                        {
                            append = false
                            
                            break
                        }
                    }
                    
                    if append
                    {
                        numbers.append(numberLowerCase)
                        
                        if mutableString.string.isEmpty
                        {
                            mutableString.append(stringBreak)
                        }
                        else
                        {
                            mutableString.append(stringSeparator)
                        }
                        
                        let numberString:NSAttributedString = NSAttributedString(
                            string:numberLowerCase,
                            attributes:attributes)
                        
                        mutableString.append(numberString)
                    }
                }
            }
        }
        
        return mutableString
    }
}
