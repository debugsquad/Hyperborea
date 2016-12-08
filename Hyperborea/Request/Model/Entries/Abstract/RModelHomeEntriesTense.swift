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
    private let kTenseSeparator:String = ", "
    
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
        
        let attributesSection:[String:Any] = [
            NSFontAttributeName:UIFont.regular(
                size:RModelHomeEntriesItem.kTitleFontSize),
            NSForegroundColorAttributeName:UIColor(
                white:RModelHomeEntriesItem.kTitleWhite,
                alpha:1)
        ]
        
        let sectionTitle:String = NSLocalizedString(
            "RModelHomeEntriesEtymologies_title",
            comment:"")
        let sectionTitleString:NSAttributedString = NSAttributedString(
            string:sectionTitle,
            attributes:attributesSection)
        
        mutableString.append(sectionTitleString)
        
        for title:String in titles
        {
            let attributes:[String:Any] = [
                NSFontAttributeName:UIFont.regular(
                    size:RModelHomeEntriesItem.kDefinitionFontSize),
                NSForegroundColorAttributeName:UIColor(
                    white:RModelHomeEntriesItem.kExampleWhite,
                    alpha:1)
            ]
            
            let titleSeparator:String = "\(kEtymologieSeparator)\(title)"
            let titleString:NSAttributedString = NSAttributedString(
                string:titleSeparator,
                attributes:attributes)
            
            mutableString.append(titleString)
        }
        
        return mutableString
    }
}
