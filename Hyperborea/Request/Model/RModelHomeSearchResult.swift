import UIKit

class RModelHomeSearchResult
{
    let attributedString:NSAttributedString
    let cellWidth:CGFloat
    let word:String
    let wordId:String
    private let kKeyWord:String = "word"
    private let kKeyWordId:String = "id"
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
            let word:String = jsonMap?[kKeyWord] as? String
        
        else
        {
            return nil
        }
        
        self.wordId = wordId
        self.word = word
        
        attributedString = NSAttributedString(
            string:word,
            attributes:attributes)
        
        let cellSize:CGSize = attributedString.boundingRect(
            with:size,
            options:options,
            context:nil).size
        cellWidth = ceil(cellSize.width) + kCellMargin
    }
}
