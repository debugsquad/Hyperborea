import Foundation

class RModelHomeEntriesFactory
{
    static let sharedInstance:RModelHomeEntriesFactory = RModelHomeEntriesFactory()
    private let lexicalMap:[String:String]?
    private let bundleName:String
    private let kBundleIdentifier:String = "CFBundleExecutable"
    private let kResourceName:String = "ResourceLexicalCategory"
    private let kResourceExtension:String = "plist"
    private let kEmpty:String = ""
    
    private init()
    {
        guard
            
            let resourceUrl:URL = Bundle.main.url(
                forResource:kResourceName,
                withExtension:kResourceExtension),
            let lexicalDictionary:NSDictionary = NSDictionary(
                contentsOf:resourceUrl),
            let lexicalMap:[String:String] = lexicalDictionary as? [String:String],
            let bundleName:String = Bundle.main.infoDictionary?[
                kBundleIdentifier] as? String
            
        else
        {
            self.lexicalMap = nil
            self.bundleName = kEmpty
            
            return
        }
        
        self.lexicalMap = lexicalMap
        self.bundleName = bundleName
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
