import Foundation

class RModelHomeEntriesFactory
{
    static let sharedInstance:RModelHomeEntriesFactory = RModelHomeEntriesFactory()
    private let lexicalMap:[String:String]?
    private let kResourceName:String = "ResourceLexicalCategory"
    private let kResourceExtension:String = "plist"
    private let kEmpty:String = ""
    
    private init()
    {
        guard
            
            let resourceUrl:URL = Bundle.main.url(
                forResource:kResourceName,
                withExtension:kResourceExtension)
            
        else
        {
            lexicalMap = nil
            
            return
        }
        
        guard
            
            let lexicalDictionary:NSDictionary = NSDictionary(
                contentsOf:resourceUrl)
            
        else
        {
            lexicalMap = nil
            
            return
        }
        
        lexicalMap = lexicalDictionary as? [String:String]
    }
    
    //MARK: public
    
    func itemWidthLexical(category:String) -> RModelHomeEntriesItem.Type?
    {
        guard
            
            let className:String = lexicalMap?[category],
            let classType:AnyObject.Type = NSClassFromString(className)
        
        else
        {
            return nil
        }
        
        let itemType:RModelHomeEntriesItem.Type? = classType as? RModelHomeEntriesItem.Type
        
        return itemType
    }
}
