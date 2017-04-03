import UIKit

class MSearchEntry
{
    let attributedString:NSAttributedString
    let word:String
    private let kKeyResults:String = "results"
    private let kKeyWord:String = "word"
    private let kKeyLexicalEntries:String = "lexicalEntries"
    private let kKeyLexicalCategory:String = "lexicalCategory"
    private let kEmpty:String = ""
    private let kWordFontSize:CGFloat = 35
    
    init(json:Any)
    {
        guard
            
            let jsonMap:[String:Any] = json as? [String:Any],
            let jsonResults:[Any] = jsonMap[kKeyResults] as? [Any]
            
        else
        {
            attributedString = NSAttributedString()
            self.word = kEmpty
            
            return
        }
        
        let attributesWord:[String:Any] = [
            NSFontAttributeName:UIFont.medium(size:kWordFontSize)]
        var stringWord:NSAttributedString?
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        var word:String?
        
        for jsonResult:Any in jsonResults
        {
            guard
                
                let jsonResultMap:[String:Any] = jsonResult as? [String:Any],
                let jsonLexicalEntries:[Any] = jsonResultMap[kKeyLexicalEntries] as? [Any]
                
            else
            {
                continue
            }
            
            if word == nil
            {
                if let rawWord:String = jsonResultMap[kKeyWord] as? String
                {
                    word = rawWord
                    
                    let wordAndBreak:String = "\(rawWord)\n"
                    
                    stringWord = NSAttributedString(
                        string:wordAndBreak,
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
                
                let itemString:NSAttributedString = entry.attributedString
                mutableString.append(itemString)
            }
        }
        
        if let stringWord:NSAttributedString = stringWord
        {
            mutableString.insert(stringWord, at:0)
        }
        
        attributedString = mutableString
        
        guard
            
            let wordFound:String = word
        
        else
        {
            self.word = kEmpty
            
            return
        }
        
        self.word = wordFound
    }
}
