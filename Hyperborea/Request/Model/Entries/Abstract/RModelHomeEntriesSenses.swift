import UIKit

class RModelHomeEntriesSenses
{
    private var items:[RModelHomeEntriesSensesItem]
    private let kKeyEntries:String = "entries"
    private let kKeySenses:String = "senses"
    private let kKeyDefinitions:String = "definitions"
    private let kKeyExamples:String = "examples"
    private let kKeyExampleText:String = "text"
    private let kKeySubsenses:String = "subsenses"
    private let kSensesSeparator:String = "\n"
    private let kExampleSeparator:String = "\n• "
    
    init(json:Any)
    {
        items = []
        
        guard
        
            let jsonMap:[String:Any] = json as? [String:Any],
            let jsonEntries:[Any] = jsonMap[kKeyEntries] as? [Any]
        
        else
        {
            return
        }
        
        for jsonEntry:Any in jsonEntries
        {
            guard
            
                let jsonEntryMap:[String:Any] = jsonEntry as? [String:Any],
                let jsonSenses:[Any] = jsonEntryMap[kKeySenses] as? [Any]
            
            else
            {
                continue
            }
            
            for jsonSense:Any in jsonSenses
            {
                guard
                
                    let jsonSenseMap:[String:Any] = jsonSense as? [String:Any]
                
                else
                {
                    continue
                }
                
                let item:RModelHomeEntriesSensesItem = itemWithJson(json:jsonSenseMap)
                items.append(item)
                
                if let jsonSubsenses:[Any] = jsonSenseMap[kKeySubsenses] as? [Any]
                {
                    for jsonSubsense:Any in jsonSubsenses
                    {
                        guard
                            
                            let jsonSubsenseMap:[String:Any] = jsonSubsense as? [String:Any]
                        
                        else
                        {
                            continue
                        }
                        
                        let item:RModelHomeEntriesSensesItem = itemWithJson(json:jsonSubsenseMap)
                        items.append(item)
                    }
                }
            }
        }
    }
    
    //MARK: private
    
    private func itemWithJson(json:[String:Any]) -> RModelHomeEntriesSensesItem
    {
        let item:RModelHomeEntriesSensesItem = RModelHomeEntriesSensesItem()
        
        if let sensesDefinitions:[String] = json[kKeyDefinitions] as? [String]
        {
            item.title.append(contentsOf:sensesDefinitions)
        }
        
        if let sensesExamples:[Any] = json[kKeyExamples] as? [Any]
        {
            for sensesExample:Any in sensesExamples
            {
                guard
                    
                    let sensesExampleMap:[String:Any] = sensesExample as? [String:Any],
                    let exampleText:String = sensesExampleMap[kKeyExampleText] as? String
                    
                else
                {
                    continue
                }
                
                item.example.append(exampleText)
            }
        }
        
        return item
    }
    
    //MARK: public
    
    func attributedString() -> NSAttributedString
    {
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
        let attributesTitle:[String:Any] = [
            NSFontAttributeName:UIFont.medium(
                size:RModelHomeEntriesItem.kDefinitionFontSize),
            NSForegroundColorAttributeName:UIColor(
                white:RModelHomeEntriesItem.kDefinitionWhite,
                alpha:1)
        ]
        
        let attributesExample:[String:Any] = [
            NSFontAttributeName:UIFont.italic(
                size:RModelHomeEntriesItem.kExampleFontSize),
            NSForegroundColorAttributeName:UIColor(
                white:RModelHomeEntriesItem.kExampleWhite,
                alpha:1)
        ]
        
        let attributesSeparator:[String:Any] = [
            NSFontAttributeName:UIFont.regular(
                size:RModelHomeEntriesItem.kSeparatorFontSize),
            NSForegroundColorAttributeName:UIColor(
                white:RModelHomeEntriesItem.kSeparatorWhite,
                alpha:1)
        ]
        
        for item:RModelHomeEntriesSensesItem in items
        {
            if !mutableString.string.isEmpty
            {
                let separatorString:NSAttributedString = NSAttributedString(
                    string:kSensesSeparator,
                    attributes:attributesTitle)
                
                mutableString.append(separatorString)
            }
            
            for title:String in item.title
            {
                let titleSeparator:String = "\(kSensesSeparator)\(title)"
                let titleString:NSAttributedString = NSAttributedString(
                    string:titleSeparator,
                    attributes:attributesTitle)
                
                mutableString.append(titleString)
            }
            
            for example:String in item.example
            {
                let separatorString:NSAttributedString = NSAttributedString(
                    string:kExampleSeparator,
                    attributes:attributesSeparator)
                
                let exampleString:NSAttributedString = NSAttributedString(
                    string:example,
                    attributes:attributesExample)
                
                mutableString.append(separatorString)
                mutableString.append(exampleString)
            }
        }
        
        return mutableString
    }
}
