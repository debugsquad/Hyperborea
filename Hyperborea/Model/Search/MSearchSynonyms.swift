import UIKit

class MSearchSynonyms
{
    private let kKeyResults:String = "results"
    private let kKeyLexicalEntries:String = "lexicalEntries"
    private let kKeyEntries:String = "entries"
    private let kKeySenses:String = "senses"
    private let kKeyExamples:String = "examples"
    private let kKeySynonyms:String = "synonyms"
    private let kKeySubsenses:String = "subsenses"
    private let kKeyText:String = "text"
    private let kExampleFontSize:CGFloat = 18
    private let kSenseSynonymFontSize:CGFloat = 18
    private let kSubsenseSynonymFontSize:CGFloat = 16
    
    init?(json:Any)
    {
        guard
        
            let jsonMap:[String:Any] = json as? [String:Any],
            let jsonResults:[Any] = jsonMap[kKeyResults] as? [Any]
        
        else
        {
            return nil
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
            
            for jsonLexicalEntry:Any in jsonLexicalEntries
            {
                guard
                
                    let jsonLexicalEntryMap:[String:Any] = jsonLexicalEntry as? [String:Any],
                    let jsonEntries:[Any] = jsonLexicalEntryMap[kKeyEntries] as? [Any]
                
                else
                {
                    continue
                }
                
                for jsonEntry:Any in jsonEntries
                {
                    guard
                    
                        let jsonEntryMap:[String:Any] = jsonEntry as? [String:Any],
                        let jsonEntrySenses:[Any] = jsonEntryMap[kKeySenses] as? [Any]
                    
                    else
                    {
                        continue
                    }
                    
                    for jsonEntrySense:Any in jsonEntrySenses
                    {
                        guard
                        
                            let jsonSenseMap:[String:Any] = jsonEntrySense as? [String:Any]
                        
                        else
                        {
                            continue
                        }
                        
                        if let jsonExamples:[Any] = jsonSenseMap[kKeyExamples] as? [Any]
                        {
                            for jsonExample:Any in jsonExamples
                            {
                                guard
                                
                                    let jsonExampleMap:[String:Any] = jsonExample as? [String:Any],
                                    let jsonExampleText:String = jsonExampleMap[kKeyText] as? String
                                
                                else
                                {
                                    continue
                                }
                                
                                
                            }
                        }
                        
                        if let jsonSynonyms:[Any] = jsonSenseMap[kKeySynonyms] as? [Any]
                        {
                            
                        }
                        
                        if let jsonSubsenses[Any] = jsonSenseMap[kKeySubsenses] as? [Any]
                        {
                            
                        }
                    }
                }
            }
        }
    }
}
