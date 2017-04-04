import UIKit

class MSearchEntryTense
{
    private static let kKeyEntries:String = "entries"
    
    class func parse(json:Any) -> NSAttributedString?
    {
        guard
            
            let jsonMap:[String:Any] = json as? [String:Any],
            let jsonEntries:[Any] = jsonMap[kKeyEntries] as? [Any]
            
        else
        {
            return nil
        }
        
        var tenses:[String] = []
        
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
                
                if featureMapType == kTypeTense
                {
                    tenses.insert(featureMapText, at:0)
                }
                else if featureMapType == kTypeNotFinite
                {
                    tenses.append(featureMapText)
                }
            }
        }
    }
}
