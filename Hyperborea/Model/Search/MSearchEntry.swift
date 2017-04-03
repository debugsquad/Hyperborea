import Foundation

class MSearchEntry
{
    let items:[MSearchEntryItem]
    let word:String
    private let kKeyResults:String = "results"
    private let kKeyWord:String = "word"
    private let kKeyLexicalEntries:String = "lexicalEntries"
    private let kKeyLexicalCategory:String = "lexicalCategory"
    private let kEmpty:String = ""
    
    init(json:Any)
    {
        guard
            
            let jsonMap:[String:Any] = json as? [String:Any],
            let jsonResults:[Any] = jsonMap[kKeyResults] as? [Any]
            
        else
        {
            self.items = []
            self.word = kEmpty
            
            return
        }
        
        var items:[MSearchEntryItem] = []
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
            
            if let rawWord:String = jsonResultMap[kKeyWord] as? String
            {
                word = rawWord
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
                
                items.append(entry)
            }
        }
        
        guard
            
            let wordFound:String = word
        
        else
        {
            self.items = []
            self.word = kEmpty
            
            return
        }
        
        self.items = []
        self.word = wordFound
    }
}
