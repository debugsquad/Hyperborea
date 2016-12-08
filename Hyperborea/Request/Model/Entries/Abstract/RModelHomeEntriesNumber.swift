import UIKit

class RModelHomeEntriesNumber
{
    private let numbers:[String]
    private let kKeyEntries:String = "entries"
    private let kKeyGrammaticalFeatures:String = "grammaticalFeatures"
    private let kKeyType:String = "type"
    private let kKeyText:String = "text"
    private let kTypeNumber:String = "Number"
    private let kGroupSeparator:String = "  "
    private let kNumberSeparator:String = " | "
    
    init(json:Any)
    {
        var numbers:[String] = []
        
        guard
            
            let jsonMap:[String:Any] = json as? [String:Any],
            let jsonEntries:[Any] = jsonMap[kKeyEntries] as? [Any],
            let jsonEntriesFirst:[String:Any] = jsonEntries.first as? [String:Any],
            let jsonFeatures:[Any] = jsonEntriesFirst[kKeyGrammaticalFeatures] as? [Any]
            
        else
        {
            self.numbers = numbers
            
            return
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
                numbers.append(featureMapText)
            }
        }
        
        self.numbers = numbers
    }
    
    //MARK: public
    
    func attributedString() -> NSAttributedString
    {
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
        if !numbers.isEmpty
        {
            let attributes:[String:Any] = [
                NSFontAttributeName:UIFont.regular(
                    size:RModelHomeEntriesItem.kComplementFontSize),
                NSForegroundColorAttributeName:UIColor(
                    white:RModelHomeEntriesItem.kComplementWhite,
                    alpha:1)
            ]
            
            let attributesSeparator:[String:Any] = [
                NSFontAttributeName:UIFont.regular(
                    size:RModelHomeEntriesItem.kSeparatorFontSize),
                NSForegroundColorAttributeName:UIColor(
                    white:RModelHomeEntriesItem.kSeparatorWhite,
                    alpha:1)
            ]
            
            for number:String in numbers
            {
                let compositeString:String
                let numberLowerCase:String = number.lowercased()
                
                if mutableString.string.isEmpty
                {
                    compositeString = "\(kGroupSeparator)\(numberLowerCase)"
                }
                else
                {
                    let separatorString:NSAttributedString = NSAttributedString(
                        string:kNumberSeparator,
                        attributes:attributesSeparator)
                    mutableString.append(separatorString)
                    
                    compositeString = numberLowerCase
                }
                
                let numberString:NSAttributedString = NSAttributedString(
                    string:compositeString,
                    attributes:attributes)
                
                mutableString.append(numberString)
            }
        }
        
        return mutableString
    }
}
