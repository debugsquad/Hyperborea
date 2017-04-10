import UIKit

class MSearchOrigins
{
    let attributedString:NSAttributedString
    private let kBreak:String = "\n"
    private let kKeyResults:String = "results"
    private let kKeyWord:String = "word"
    private let kKeyLexicalEntries:String = "lexicalEntries"
    private let kKeyEntries:String = "entries"
    private let kKeyEtymologies:String = "etymologies"
    private let kWordFontSize:CGFloat = 40
    private let kFontSize:CGFloat = 18
    private let kNotFoundFontSize:CGFloat = 18
    
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
        
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:kFontSize),
            NSForegroundColorAttributeName:UIColor.black]
        let stringBreak:NSAttributedString = NSAttributedString(
            string:kBreak,
            attributes:attributes)
        
        var wordString:NSAttributedString?
        
        for jsonResult:Any in jsonResults
        {
            guard
            
                let jsonResultMap:[String:Any] = jsonResult as? [String:Any],
                let jsonLexicalEntries:[Any] = jsonResultMap[kKeyLexicalEntries] as? [Any]
            
            else
            {
                continue
            }
            
            if wordString == nil
            {
                if let word:String = jsonResultMap[kKeyWord] as? String
                {
                    let wordCapitalized:String = word.capitalizedFirstLetter()
                    let attributesWord:[String:AnyObject] = [
                        NSFontAttributeName:UIFont.medium(size:kWordFontSize),
                        NSForegroundColorAttributeName:UIColor.black]
                    wordString = NSAttributedString(
                        string:wordCapitalized,
                        attributes:attributesWord)
                }
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
                        let jsonEtymologies:[Any] = jsonEntryMap[kKeyEtymologies] as? [Any]
                    
                    else
                    {
                        continue
                    }
                    
                    for jsonEtymology:Any in jsonEtymologies
                    {
                        guard
                        
                            let titleEtymology:String = jsonEtymology as? String
                        
                        else
                        {
                            continue
                        }
                        
                        let stringEtymology:NSAttributedString = NSAttributedString(
                            string:titleEtymology,
                            attributes:attributes)
                        
                        if !mutableString.string.isEmpty
                        {
                            mutableString.append(stringBreak)
                        }
                        
                        mutableString.append(stringEtymology)
                    }
                }
            }
        }
        
        if let wordString:NSAttributedString = wordString
        {
            if !mutableString.string.isEmpty
            {
                mutableString.insert(stringBreak, at:0)
                mutableString.insert(stringBreak, at:0)
            }
            
            mutableString.insert(wordString, at:0)
        }
        
        attributedString = mutableString
    }
    
    init()
    {
        let string:String = NSLocalizedString("MSearchOrigins_notFound", comment:"")
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:kNotFoundFontSize),
            NSForegroundColorAttributeName:UIColor(white:0.4, alpha:1)]
        attributedString = NSAttributedString(
            string:string,
            attributes:attributes)
    }
}
