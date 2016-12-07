import Foundation

class RModelHomeEntries:RModel
{
    let items:[RModelHomeEntriesItem]
    private let kKeyResults:String = "results"
    private let kFontSizeCategory:CGFloat = 14
    private let kMaxWidth:CGFloat = 2000
    private let kMaxHeight:CGFloat = 20
    
    required init(json:Any)
    {
        var items:[RModelHomeEntriesItem] = []
        
        let jsonMap:[String:Any]? = json as? [String:Any]
        
        if let jsonResults:[Any] = jsonMap?[kKeyResults] as? [Any]
        {
            
        }
        
        self.items = items
        
        super.init()
    }
    
    override init()
    {
        fatalError()
    }
}
