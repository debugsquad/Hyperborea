import UIKit

class RModelHomeEntriesItem
{
    static let kTitleFontSize:CGFloat = 18
    static let kDefinitionFontSize:CGFloat = 15
    static let kExampleFontSize:CGFloat = 14
    static let kTitleWhite:CGFloat = 0
    static let kDefinitionWhite:CGFloat = 0.2
    static let kExampleWhite:CGFloat = 0.3
    let attributedString:NSAttributedString
    let reusableIdentifier:String
    let selectable:Bool
    private let options:NSStringDrawingOptions
    private let kMarginHorizontal:CGFloat = 20
    private let kAddHeight:CGFloat = 120
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
}
