import UIKit

class MSearchTranslations
{
    let language:MLanguage?
    let attributedString:NSAttributedString
    private static let kKeyExamples:String = "examples"
    private static let kKeyTranslations:String = "translations"
    private static let kKeyText:String = "text"
    private static let kBreak:String = "\n"
    private static let kExamplesFontSize:CGFloat = 17
    private static let kExamplesTranslationFontSize:CGFloat = 16
    private let kKeyResults:String = "results"
    private let kKeyWord:String = "word"
    private let kKeyLexicalEntries:String = "lexicalEntries"
    private let kKeyEntries:String = "entries"
    private let kKeySenses:String = "senses"
    private let kKeySubsenses:String = "subsenses"
    private let kTranslationsFontSize:CGFloat = 20
    private let kWordFontSize:CGFloat = 40
    private let kNotFoundFontSize:CGFloat = 18
    
    private class func parseExamples(json:[String:Any]) -> NSAttributedString?
    {
        guard
            
            let jsonExamples:[Any] = json[kKeyExamples] as? [Any]
            
        else
        {
            return nil
        }
        
        let attributesExample:[String:AnyObject] = [
            NSFontAttributeName:UIFont.italic(size:kExamplesFontSize),
            NSForegroundColorAttributeName:UIColor.black]
        let attributesTranslation:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:kExamplesTranslationFontSize),
            NSForegroundColorAttributeName:UIColor(white:0.5, alpha:1)]
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        let stringBreak:NSAttributedString = NSAttributedString(
            string:kBreak,
            attributes:attributesExample)
        
        for jsonExample:Any in jsonExamples
        {
            guard
                
                let jsonExampleMap:[String:Any] = jsonExample as? [String:Any],
                let jsonExampleText:String = jsonExampleMap[kKeyText] as? String,
                let jsonExampleTranslations:[Any] = jsonExampleMap[kKeyTranslations] as? [Any]
            
            else
            {
                continue
            }
            
            let stringText:NSAttributedString = NSAttributedString(
                string:jsonExampleText,
                attributes:attributesExample)
            
            mutableString.append(stringBreak)
            mutableString.append(stringText)
            mutableString.append(stringBreak)
            
            for jsonExampleTranslation:Any in jsonExampleTranslations
            {
                guard
                
                    let jsonTranslationMap:[String:Any] = jsonExampleTranslation as? [String:Any],
                    let jsonTranslationText:String = jsonTranslationMap[kKeyText] as? String
                
                else
                {
                    continue
                }
                
                let stringText:NSAttributedString = NSAttributedString(
                    string:jsonTranslationText,
                    attributes:attributesTranslation)
                
                mutableString.append(stringText)
                mutableString.append(stringBreak)
            }
        }
        
        return mutableString
    }
    
    init(
        language:MLanguage,
        json:Any)
    {
        self.language = language
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
        guard
            
            let jsonMap:[String:Any] = json as? [String:Any],
            let jsonResults:[Any] = jsonMap[kKeyResults] as? [Any]
            
        else
        {
            attributedString = mutableString
            
            return
        }
        
        let attributesTranslations:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:kTranslationsFontSize),
            NSForegroundColorAttributeName:UIColor.black]
        let attributesWord:[String:AnyObject] = [
            NSFontAttributeName:UIFont.medium(size:kWordFontSize),
            NSForegroundColorAttributeName:UIColor.black]
        var stringWord:NSAttributedString?
        let stringBreak:NSAttributedString = NSAttributedString(
            string:MSearchTranslations.kBreak,
            attributes:attributesWord)
        var translations:[String] = []
        
        for jsonResult:Any in jsonResults
        {
            guard
                
                let jsonResultMap:[String:Any] = jsonResult as? [String:Any],
                let jsonLexicalEntries:[Any] = jsonResultMap[kKeyLexicalEntries] as? [Any]
                
            else
            {
                continue
            }
            
            if stringWord == nil
            {
                if let rawWord:String = jsonResultMap[kKeyWord] as? String
                {
                    stringWord = NSAttributedString(
                        string:rawWord,
                        attributes:attributesWord)
                }
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
                        
                        if let jsonTranslations:[Any] = jsonSenseMap[
                            MSearchTranslations.kKeyTranslations] as? [Any]
                        {
                            for jsonTranslation:Any in jsonTranslations
                            {
                                guard
                                
                                    let jsonTranslationMap:[String:Any] = jsonTranslation as? [String:Any],
                                    let jsonTranslationText:String = jsonTranslationMap[
                                        MSearchTranslations.kKeyText] as? String
                                
                                else
                                {
                                    continue
                                }
                                
                                var append:Bool = true
                                
                                for translation:String in translations
                                {
                                    if translation == jsonTranslationText
                                    {
                                        append = false
                                        
                                        break
                                    }
                                }
                                
                                if append
                                {
                                    translations.append(jsonTranslationText)
                                }
                            }
                        }
                        
                        if let exampleString:NSAttributedString = MSearchTranslations.parseExamples(
                            json:jsonSenseMap)
                        {
                            mutableString.append(exampleString)
                        }
                        
                        if let jsonSubsenses:[Any] = jsonSenseMap[kKeySubsenses] as? [Any]
                        {
                            for jsonSubsense:Any in jsonSubsenses
                            {
                                guard
                                
                                    let jsonSubsenseMap:[String:Any] = jsonSubsense as? [String:Any],
                                    let exampleString:NSAttributedString = MSearchTranslations.parseExamples(
                                        json:jsonSubsenseMap)
                                
                                else
                                {
                                    continue
                                }
                                
                                mutableString.append(exampleString)
                            }
                        }
                    }
                }
            }
        }
        
        let translationsString:NSMutableAttributedString = NSMutableAttributedString()
        
        for translation:String in translations
        {
            let stringTranslation:NSAttributedString = NSAttributedString(
                string:translation,
                attributes:attributesTranslations)
            
            translationsString.append(stringTranslation)
            translationsString.append(stringBreak)
        }
        
        mutableString.insert(translationsString, at:0)
        
        if let stringWord:NSAttributedString = stringWord
        {
            mutableString.insert(stringBreak, at:0)
            mutableString.insert(stringWord, at:0)
        }
        
        attributedString = mutableString
    }
    
    init()
    {
        let string:String = NSLocalizedString("MSearchTranslations_notFound", comment:"")
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:kNotFoundFontSize),
            NSForegroundColorAttributeName:UIColor(white:0.4, alpha:1)]
        
        attributedString = NSAttributedString(
            string:string,
            attributes:attributes)
        language = nil
    }
}
