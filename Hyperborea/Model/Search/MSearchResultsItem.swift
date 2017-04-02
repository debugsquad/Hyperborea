import UIKit

class MSearchResultsItem
{
    private static let kReplaceA:String = "á"
    private static let kReplaceE:String = "é"
    private static let kReplaceI:String = "í"
    private static let kReplaceO:String = "ó"
    private static let kReplaceU:String = "ú"
    private static let kReplaceExcalamation:String = "¡"
    private static let kNormalA:String = "a"
    private static let kNormalE:String = "e"
    private static let kNormalI:String = "i"
    private static let kNormalO:String = "o"
    private static let kNormalU:String = "u"
    private static let kNormalExclamation:String = "%C2%A1"
    
    let wordId:String
    let word:String
    let matchType:String
    let region:String?
    var attributedString:NSAttributedString?
    var cellWidth:CGFloat
    var cellHeight:CGFloat
    private let kKeyWord:String = "word"
    private let kKeyWordId:String = "id"
    private let kKeyRegion:String = "region"
    private let kKeyMathType:String = "matchType"
    
    private class func normalizeWordId(wordId:String) -> String
    {
        var newWordId:String = wordId
        
        newWordId = newWordId.replacingOccurrences(
            of:kReplaceA,
            with:kNormalA)
        newWordId = newWordId.replacingOccurrences(
            of:kReplaceE,
            with:kNormalE)
        newWordId = newWordId.replacingOccurrences(
            of:kReplaceI,
            with:kNormalI)
        newWordId = newWordId.replacingOccurrences(
            of:kReplaceO,
            with:kNormalO)
        newWordId = newWordId.replacingOccurrences(
            of:kReplaceU,
            with:kNormalU)
        newWordId = newWordId.replacingOccurrences(
            of:kReplaceExcalamation,
            with:kNormalExclamation)
        
        return newWordId
    }
    
    init?(json:Any)
    {
        let jsonMap:[String:Any]? = json as? [String:Any]
        
        guard
            
            let rawWordId:String = jsonMap?[kKeyWordId] as? String,
            let matchType:String = jsonMap?[kKeyMathType] as? String,
            let encodedWord:String = jsonMap?[kKeyWord] as? String,
            let word:String = encodedWord.removingPercentEncoding
            
        else
        {
            return nil
        }
        
        let wordId:String = MSearchResultsItem.normalizeWordId(
            wordId:rawWordId)
        
        cellWidth = 0
        cellHeight = 0
        self.region = jsonMap?[kKeyRegion] as? String
        self.wordId = wordId
        self.word = word
        self.matchType = matchType
    }
}
