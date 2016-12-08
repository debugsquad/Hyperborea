import UIKit

class RModelHomeEntriesTense
{
    private let tenses:[String]
    private let kKeyEntries:String = "entries"
    private let kKeyGrammaticalFeatures:String = "grammaticalFeatures"
    private let kKeyType:String = "type"
    private let kKeyText:String = "text"
    private let kTypeTense:String = "Tense"
    private let kTypeNotFinite:String = "Non Finiteness"
    private let kGroupSeparator:String = "  "
    private let kTenseSeparator:String = " | "
    
    init(json:Any)
    {
        var tenses:[String] = []
        
        guard
            
            let jsonMap:[String:Any] = json as? [String:Any],
            let jsonEntries:[Any] = jsonMap[kKeyEntries] as? [Any],
            let jsonEntriesFirst:[String:Any] = jsonEntries.first as? [String:Any],
            let jsonFeatures:[Any] = jsonEntriesFirst[kKeyGrammaticalFeatures] as? [Any]
            
        else
        {
            self.tenses = tenses
            
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
            
            if featureMapType == kTypeTense
            {
                tenses.insert(featureMapText, at:0)
            }
            else if featureMapType == kTypeNotFinite
            {
                tenses.append(featureMapText)
            }
        }
        
        self.tenses = tenses
    }
    
    //MARK: public
    
    func attributedString() -> NSAttributedString
    {
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
        if !tenses.isEmpty
        {
            for tense:String in tenses
            {
                let attributes:[String:Any] = [
                    NSFontAttributeName:UIFont.regular(
                        size:RModelHomeEntriesItem.kComplementFontSize),
                    NSForegroundColorAttributeName:UIColor(
                        white:RModelHomeEntriesItem.kComplementWhite,
                        alpha:1)
                ]
                
                let compositeString:String
                let tenseLowerCase:String = tense.lowercased()
                
                if mutableString.string.isEmpty
                {
                    compositeString = "\(kGroupSeparator)\(tenseLowerCase)"
                }
                else
                {
                    compositeString = "\(kTenseSeparator)\(tenseLowerCase)"
                }
                
                let tenseString:NSAttributedString = NSAttributedString(
                    string:compositeString,
                    attributes:attributes)
                
                mutableString.append(tenseString)
            }
        }
        
        return mutableString
    }
}
