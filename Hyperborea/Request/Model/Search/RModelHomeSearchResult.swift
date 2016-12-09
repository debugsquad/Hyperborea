import UIKit

class RModelHomeSearchResult
{
    private(set) var wordId:String
    let attributedString:NSAttributedString
    let cellWidth:CGFloat
    let word:String
    let matchType:String
    let region:String?
    private let kKeyWord:String = "word"
    private let kKeyWordId:String = "id"
    private let kKeyRegion:String = "region"
    private let kKeyMathType:String = "matchType"
    private let kNormalised:String = "normalised"
    private let kReplaceA:String = "á"
    private let kReplaceE:String = "é"
    private let kReplaceI:String = "í"
    private let kReplaceO:String = "ó"
    private let kReplaceU:String = "ú"
    private let kReplaceExcalamation:String = "¡"
    private let kNormalA:String = "a"
    private let kNormalE:String = "e"
    private let kNormalI:String = "i"
    private let kNormalO:String = "o"
    private let kNormalU:String = "u"
    private let kNormalExclamation:String = "%C2%A1"
    private let kEmpty:String = ""
    private let kCellMargin:CGFloat = 35
    
    init?(
        json:Any,
        attributes:[String:Any],
        size:CGSize,
        options:NSStringDrawingOptions)
    {
        let jsonMap:[String:Any]? = json as? [String:Any]
        
        guard
        
            let wordId:String = jsonMap?[kKeyWordId] as? String,
            let matchType:String = jsonMap?[kKeyMathType] as? String,
            let encodedWord:String = jsonMap?[kKeyWord] as? String,
            let word:String = encodedWord.removingPercentEncoding
        
        else
        {
            return nil
        }
        
        self.region = jsonMap?[kKeyRegion] as? String
        self.wordId = wordId
        self.word = word
        self.matchType = matchType
        
        attributedString = NSAttributedString(
            string:word,
            attributes:attributes)
        
        let cellSize:CGSize = attributedString.boundingRect(
            with:size,
            options:options,
            context:nil).size
        cellWidth = ceil(cellSize.width) + kCellMargin
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.normalize()
        }
    }
    
    //MARK: private
    
    private func normalize()
    {
        wordId = wordId.replacingOccurrences(
            of:kReplaceA,
            with:kNormalA)
        wordId = wordId.replacingOccurrences(
            of:kReplaceE,
            with:kNormalE)
        wordId = wordId.replacingOccurrences(
            of:kReplaceI,
            with:kNormalI)
        wordId = wordId.replacingOccurrences(
            of:kReplaceO,
            with:kNormalO)
        wordId = wordId.replacingOccurrences(
            of:kReplaceU,
            with:kNormalU)
        wordId = wordId.replacingOccurrences(
            of:kReplaceExcalamation,
            with:kNormalExclamation)
    }
}
