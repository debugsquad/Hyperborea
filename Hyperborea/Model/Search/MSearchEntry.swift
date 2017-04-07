import UIKit

class MSearchEntry
{
    let attributedString:NSAttributedString
    let wordId:String
    let word:String
    let languageRaw:Int16
    let region:String?
    let origins:MSearchOrigins
    var synonyms:MSearchSynonyms?
    var antonyms:MSearchAntonyms?
    var translations:MSearchTranslations?
    private let kKeyResults:String = "results"
    private let kKeyWord:String = "word"
    private let kKeyLexicalEntries:String = "lexicalEntries"
    private let kKeyLexicalCategory:String = "lexicalCategory"
    private let kBreak:String = "\n"
    private let kWordFontSize:CGFloat = 40
    private let kNotFoundFontSize:CGFloat = 18
    
    init(
        wordId:String,
        word:String,
        languageRaw:Int16,
        region:String?,
        json:Any)
    {
        self.wordId = wordId
        self.word = word
        self.languageRaw = languageRaw
        self.region = region
        
        guard
            
            let jsonMap:[String:Any] = json as? [String:Any],
            let jsonResults:[Any] = jsonMap[kKeyResults] as? [Any]
            
        else
        {
            origins = MSearchOrigins()
            attributedString = NSAttributedString()
            
            return
        }
        
        let attributesWord:[String:AnyObject] = [
            NSFontAttributeName:UIFont.medium(size:kWordFontSize),
            NSForegroundColorAttributeName:UIColor.black]
        let stringWord:NSAttributedString = NSAttributedString(
            string:word,
            attributes:attributesWord)
        let stringBreak:NSAttributedString = NSAttributedString(
            string:kBreak,
            attributes:attributesWord)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(stringWord)
        
        for jsonResult:Any in jsonResults
        {
            guard
                
                let jsonResultMap:[String:Any] = jsonResult as? [String:Any],
                let jsonLexicalEntries:[Any] = jsonResultMap[kKeyLexicalEntries] as? [Any]
                
            else
            {
                continue
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
                mutableString.append(stringBreak)
                mutableString.append(itemString)
                mutableString.append(stringBreak)
            }
        }
        
        attributedString = mutableString
        origins = MSearchOrigins(json:json)
    }
    
    init(
        wordId:String,
        word:String,
        languageRaw:Int16,
        region:String?)
    {
        self.wordId = wordId
        self.word = word
        self.languageRaw = languageRaw
        self.region = region
        
        let string:String = NSLocalizedString("MSearchEntry_notFound", comment:"")
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:kNotFoundFontSize),
            NSForegroundColorAttributeName:UIColor(white:0.4, alpha:1)]
        attributedString = NSAttributedString(
            string:string,
            attributes:attributes)
        
        origins = MSearchOrigins()
    }
}
