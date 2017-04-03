import UIKit

class MSearchEntryItem
{
    let attributedString:NSAttributedString
    let reusableIdentifier:String
    let selectable:Bool
    let options:NSStringDrawingOptions
    private let kMarginHorizontal:CGFloat = 20
    private let kAddHeight:CGFloat = 68
    private let kMaxHeight:CGFloat = 90000
    
    required init?(json:Any)
    {
        return nil
    }
    
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
