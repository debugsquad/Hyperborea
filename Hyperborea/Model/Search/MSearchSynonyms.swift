import UIKit

class MSearchSynonyms
{
    let attributedString:NSAttributedString
    private static let kKeySynonyms:String = "synonyms"
    private static let kKeyText:String = "text"
    private static let kBreak:String = "\n"
    private let kKeyResults:String = "results"
    private let kKeyLexicalEntries:String = "lexicalEntries"
    private let kKeyEntries:String = "entries"
    private let kKeySenses:String = "senses"
    private let kKeyExamples:String = "examples"
    private let kKeySubsenses:String = "subsenses"
    private let kExampleFontSize:CGFloat = 21
    private let kSensesFontSize:CGFloat = 16
    private let kSubsensesFontSize:CGFloat = 16
    
    private class func parseSynonyms(
        json:[String:Any],
        attributes:[String:AnyObject]) -> NSAttributedString?
    {
        guard
        
            let jsonSynonyms:[Any] = json[kKeySynonyms] as? [Any]
        
        else
        {
            return nil
        }
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        let stringBreak:NSAttributedString = NSAttributedString(
            string:kBreak,
            attributes:attributes)
        
        for jsonSynonym:Any in jsonSynonyms
        {
            guard
            
                let jsonSynonymMap:[String:Any] = jsonSynonym as? [String:Any],
                let jsonSynonymText:String = jsonSynonymMap[kKeyText] as? String
            
            else
            {
                continue
            }
            
            let stringText:NSAttributedString = NSAttributedString(
                string:jsonSynonymText,
                attributes:attributes)
            
            mutableString.append(stringBreak)
            mutableString.append(stringText)
        }
        
        return mutableString
    }
    
    init(json:Any)
    {
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
        guard
        
            let jsonMap:[String:Any] = json as? [String:Any],
            let jsonResults:[Any] = jsonMap[kKeyResults] as? [Any]
        
        else
        {
            attributedString = mutableString
            
            return
        }
        
        let attributesExample:[String:AnyObject] = [
            NSFontAttributeName:UIFont.italic(size:kExampleFontSize),
            NSForegroundColorAttributeName:UIColor.black]
        let attributesSenses:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:kSensesFontSize),
            NSForegroundColorAttributeName:UIColor(white:0.1, alpha:1)]
        let attributesSubsenses:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:kSubsensesFontSize),
            NSForegroundColorAttributeName:UIColor(white:0.5, alpha:1)]
        
        let stringBreak:NSAttributedString = NSAttributedString(
            string:MSearchSynonyms.kBreak,
            attributes:attributesExample)
        
        for jsonResult:Any in jsonResults
        {
            guard
                
                let jsonResultMap:[String:Any] = jsonResult as? [String:Any],
                let jsonLexicalEntries:[Any] = jsonResultMap[kKeyLexicalEntries] as? [Any]
                
            else
            {
                continue
            }
            
            for jsonLexicalEntry:Any in jsonLexicalEntries
            {
                guard
                
                    let jsonLexicalEntryMap:[String:Any] = jsonLexicalEntry as? [String:Any],
                    let jsonEntries:[Any] = jsonLexicalEntryMap[kKeyEntries] as? [Any]
                
                else
                {
                    continue
                }
                
                for jsonEntry:Any in jsonEntries
                {
                    guard
                    
                        let jsonEntryMap:[String:Any] = jsonEntry as? [String:Any],
                        let jsonEntrySenses:[Any] = jsonEntryMap[kKeySenses] as? [Any]
                    
                    else
                    {
                        continue
                    }
                    
                    for jsonEntrySense:Any in jsonEntrySenses
                    {
                        guard
                        
                            let jsonSenseMap:[String:Any] = jsonEntrySense as? [String:Any]
                        
                        else
                        {
                            continue
                        }
                        
                        if let jsonExamples:[Any] = jsonSenseMap[kKeyExamples] as? [Any]
                        {
                            for jsonExample:Any in jsonExamples
                            {
                                guard
                                
                                    let jsonExampleMap:[String:Any] = jsonExample as? [String:Any],
                                    let jsonExampleText:String = jsonExampleMap[
                                        MSearchSynonyms.kKeyText] as? String
                                
                                else
                                {
                                    continue
                                }
                                
                                if !mutableString.string.isEmpty
                                {
                                    mutableString.append(stringBreak)
                                    mutableString.append(stringBreak)
                                }
                                
                                let stringExample:NSAttributedString = NSAttributedString(
                                    string:jsonExampleText,
                                    attributes:attributesExample)
                                
                                mutableString.append(stringExample)
                            }
                        }
                        
                        if let synonymsString:NSAttributedString = MSearchSynonyms.parseSynonyms(
                            json:jsonSenseMap,
                            attributes:attributesSenses)
                        {
                            mutableString.append(synonymsString)
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
                                
                                if let synonymsString:NSAttributedString = MSearchSynonyms.parseSynonyms(
                                    json:jsonSubsenseMap,
                                    attributes:attributesSubsenses)
                                {
                                    mutableString.append(synonymsString)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        attributedString = mutableString
    }
}
