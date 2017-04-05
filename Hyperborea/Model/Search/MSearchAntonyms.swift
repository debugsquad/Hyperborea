import UIKit

class MSearchAntonyms
{
    let attributedString:NSAttributedString
    private static let kKeyAntonyms:String = "antonyms"
    private static let kKeyText:String = "text"
    private static let kBreak:String = "\n"
    private let kKeyResults:String = "results"
    private let kKeyLexicalEntries:String = "lexicalEntries"
    private let kKeyEntries:String = "entries"
    private let kKeySenses:String = "senses"
    private let kKeyExamples:String = "examples"
    private let kKeySubsenses:String = "subsenses"
    private let kExampleFontSize:CGFloat = 18
    private let kSensesFontSize:CGFloat = 14
    private let kSubsensesFontSize:CGFloat = 14
    
    private class func parseAntonyms(
        json:[String:Any],
        attributes:[String:AnyObject]) -> NSAttributedString?
    {
        guard
            
            let jsonAntonyms:[Any] = json[kKeyAntonyms] as? [Any]
            
        else
        {
            return nil
        }
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        let stringBreak:NSAttributedString = NSAttributedString(
            string:kBreak,
            attributes:attributes)
        
        for jsonAntonym:Any in jsonAntonyms
        {
            guard
                
                let jsonAntonymMap:[String:Any] = jsonAntonym as? [String:Any],
                let jsonAntonymText:String = jsonAntonymMap[kKeyText] as? String
                
            else
            {
                continue
            }
            
            let stringText:NSAttributedString = NSAttributedString(
                string:jsonAntonymText,
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
            NSForegroundColorAttributeName:UIColor.black]
        let attributesSubsenses:[String:AnyObject] = [
            NSFontAttributeName:UIFont.italic(size:kSubsensesFontSize),
            NSForegroundColorAttributeName:UIColor(white:0.5, alpha:1)]
        
        let stringBreak:NSAttributedString = NSAttributedString(
            string:MSearchAntonyms.kBreak,
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
                                        MSearchAntonyms.kKeyText] as? String
                                    
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
                        
                        if let antonymsString:NSAttributedString = MSearchAntonyms.parseAntonyms(
                            json:jsonSenseMap,
                            attributes:attributesSenses)
                        {
                            mutableString.append(antonymsString)
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
                                
                                if let antonymsString:NSAttributedString = MSearchAntonyms.parseAntonyms(
                                    json:jsonSubsenseMap,
                                    attributes:attributesSubsenses)
                                {
                                    mutableString.append(antonymsString)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        attributedString = mutableString
    }
    
    init()
    {
        let string:String = NSLocalizedString("MSearchAntonyms_notFound", comment:"")
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:kExampleFontSize),
            NSForegroundColorAttributeName:UIColor(white:0.4, alpha:1)]
        
        attributedString = NSAttributedString(
            string:string,
            attributes:attributes)
    }
}
