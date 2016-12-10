import Foundation

class RModelHomeEntries:RModel
{
    private(set) var word:String
    private(set) var items:[RModelHomeEntriesItem]
    private let kKeyResults:String = "results"
    private let kKeyWord:String = "word"
    private let kKeyLexicalEntries:String = "lexicalEntries"
    private let kKeyLexicalCategory:String = "lexicalCategory"
    private let kEmpty:String = ""
    
    required init(json:Any)
    {
        items = []
        word = kEmpty
        
        guard
            
            let jsonMap:[String:Any] = json as? [String:Any],
            let jsonResults:[Any] = jsonMap[kKeyResults] as? [Any]
        
        else
        {
            super.init()
            
            return
        }
        
        for jsonResult:Any in jsonResults
        {
            guard
            
                let jsonResultMap:[String:Any] = jsonResult as? [String:Any],
                let jsonLexicalEntries:[Any] = jsonResultMap[kKeyLexicalEntries] as? [Any]
            
            else
            {
                continue
            }
            
            if let word:String = jsonResultMap[kKeyWord] as? String
            {
                self.word = word
            }
            
            for jsonEntry:Any in jsonLexicalEntries
            {
                guard
                    
                    let jsonEntryMap:[String:Any] = jsonEntry as? [String:Any],
                    let entryCategory:String = jsonEntryMap[kKeyLexicalCategory] as? String,
                    let entryType:RModelHomeEntriesItem.Type = RModelHomeEntriesFactory.sharedInstance.itemWidthLexical(
                        category:entryCategory)
                    
                else
                {
                    continue
                }
                
                let entry:RModelHomeEntriesItem = entryType.init(json:jsonEntry)
                items.append(entry)
            }
            
            let etymologies:RModelHomeEntriesEtymologies = RModelHomeEntriesEtymologies(
                json:jsonLexicalEntries)
            
            if !etymologies.titles.isEmpty
            {
                let origin:RModelHomeEntriesItemOrigin = RModelHomeEntriesItemOrigin(
                    etymologies:etymologies)
                items.append(origin)
            }
        }
        
        super.init()
    }
    
    override init()
    {
        fatalError()
    }
}
