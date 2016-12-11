import UIKit

class RModelHomeEntriesItem
{
    static let kTitleFontSize:CGFloat = 16
    static let kDefinitionFontSize:CGFloat = 16
    static let kExampleFontSize:CGFloat = 13
    static let kComplementFontSize:CGFloat = 13
    static let kSeparatorFontSize:CGFloat = 10
    static let kTitleWhite:CGFloat = 0
    static let kDefinitionWhite:CGFloat = 0.4
    static let kExampleWhite:CGFloat = 0.3
    static let kComplementWhite:CGFloat = 0.5
    static let kSeparatorWhite:CGFloat = 0.7
    let attributedString:NSAttributedString
    let reusableIdentifier:String
    let selectable:Bool
    private let options:NSStringDrawingOptions
    private let kMarginHorizontal:CGFloat = 20
    private let kAddHeight:CGFloat = 4
    private let kMaxHeight:CGFloat = 90000
    
    init(
        attributedString:NSAttributedString,
        reusableIdentifier:String,
        selectable:Bool)
    {
        self.attributedString = attributedString
        self.reusableIdentifier = reusableIdentifier
        self.selectable = selectable
        self.options = NSStringDrawingOptions([
            NSStringDrawingOptions.usesLineFragmentOrigin,
            NSStringDrawingOptions.usesFontLeading])
    }
    
    required init(json:Any)
    {
        fatalError()
    }
    
    //MARK: public
    
    func cellHeight(cellWidth:CGFloat) -> CGFloat
    {
        let usableWidth:CGFloat = cellWidth - kMarginHorizontal
        let maxSize:CGSize = CGSize(width:usableWidth, height:kMaxHeight)
        let textSize:CGSize = attributedString.boundingRect(
            with:maxSize,
            options:options,
            context:nil).size
        let height:CGFloat = ceil(textSize.height)
        let totalHeight:CGFloat = height + kAddHeight
        
        return totalHeight
    }
    
    func exportableComplete() -> NSAttributedString
    {
        return attributedString
    }
    
    func exportableCompact() -> NSAttributedString
    {
        return attributedString
    }
}
