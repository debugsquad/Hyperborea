import UIKit

class MSearchEntry
{
    let attributedString:NSAttributedString
    let wordId:String
    var synonyms:MSearchSynonyms?
    var antonyms:MSearchAntonyms?
    var translations:MSearchTranslations?
    private let kKeyResults:String = "results"
    private let kKeyWord:String = "word"
    private let kKeyLexicalEntries:String = "lexicalEntries"
    private let kKeyLexicalCategory:String = "lexicalCategory"
    private let kBreak:String = "\n"
    private let kWordFontSize:CGFloat = 40
    private let kNotFoundFontSize:CGFloat = 20
    
    init(
        wordId:String,
        json:Any)
    {
        self.wordId = wordId
        
        guard
            
            let jsonMap:[String:Any] = json as? [String:Any],
            let jsonResults:[Any] = jsonMap[kKeyResults] as? [Any]
            
        else
        {
            attributedString = NSAttributedString()
            
            return
        }
        
        let attributesWord:[String:Any] = [
            NSFontAttributeName:UIFont.medium(size:kWordFontSize)]
        var stringWord:NSAttributedString?
        let stringBreak:NSAttributedString = NSAttributedString(
            string:kBreak,
            attributes:attributesWord)
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
        for jsonResult:Any in jsonResults
        {
            guard
                
                let jsonResultMap:[String:Any] = jsonResult as? [String:Any],
                let jsonLexicalEntries:[Any] = jsonResultMap[kKeyLexicalEntries] as? [Any]
                
            else
            {
                continue
            }
            
            if stringWord == nil
            {
                if let rawWord:String = jsonResultMap[kKeyWord] as? String
                {
                    stringWord = NSAttributedString(
                        string:rawWord,
                        attributes:attributesWord)
                }
            }
            
            for jsonEntry:Any in jsonLexicalEntries
            {
                guard
                    
                    let jsonEntryMap:[String:Any] = jsonEntry as? [String:Any],
                    let entryCategory:String = jsonEntryMap[kKeyLexicalCategory] as? String,
                    let entryType:MSearchEntryItem.Type = MSearchEntryFactory.sharedInstance?.itemWithLexical(
                        category:entryCategory),
                    let entry:MSearchEntryItem = entryType.init(json:jsonEntry)
                    
                else
                {
                    continue
                }
                
                if !mutableString.string.isEmpty
                {
                    mutableString.append(stringBreak)
                    mutableString.append(stringBreak)
                }
                
                let itemString:NSAttributedString = entry.attributedString
                mutableString.append(itemString)
            }
        }
        
        if let stringWord:NSAttributedString = stringWord
        {
            mutableString.insert(stringBreak, at:0)
            mutableString.insert(stringWord, at:0)
        }
        
        attributedString = mutableString
    }
    
    init(wordId:String)
    {
        self.wordId = wordId
        
        let string:String = NSLocalizedString("MSearchEntry_notFound", comment:"")
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:kNotFoundFontSize),
            NSForegroundColorAttributeName:UIColor(white:0.4, alpha:1)]
        attributedString = NSAttributedString(
            string:string,
            attributes:attributes)
    }
}
