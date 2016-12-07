import Foundation

class RModelHomeEntries:RModel
{
    let items:[RModelHomeEntriesItem]
    private let kKeyResults:String = "results"
    private let kKeyLexicalEntries:String = "lexicalEntries"
    private let kKeyLexicalCategory:String = "lexicalCategory"
    
    required init(json:Any)
    {
        var items:[RModelHomeEntriesItem] = []
        
        guard
            
            let jsonMap:[String:Any] = json as? [String:Any],
            let jsonResults:[Any] = jsonMap[kKeyResults] as? [Any],
            let jsonFirstResult:[String:Any] = jsonResults.first as? [String:Any],
            let jsonLexicalEntries:[Any] = jsonFirstResult[kKeyLexicalEntries] as? [Any]
        
        else
        {
            self.items = items
            super.init()
            
            return
        }
        
        for jsonEntry:Any in jsonLexicalEntries
        {
            guard
            
                let jsonEntryMap:[String:Any] = jsonEntry as? [String:Any],
                let jsonEntryCategory:String = jsonEntryMap[kKeyLexicalCategory] as? String
            
            else
            {
                continue
            }
            
            print("category: \(jsonEntryCategory)")
        }
        
        self.items = items
        
        super.init()
    }
    
    override init()
    {
        fatalError()
    }
}
