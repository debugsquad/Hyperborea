import UIKit

class VSearchContentModeCell:UICollectionViewCell
{
    private weak var labelTitle:UILabel!
    private weak var labelSymbol:UILabel!
    private weak var border:VBorder!
    private let kLabelTop:CGFloat = 64
    private let kTitleHeight:CGFloat = 25
    private let kTitleFontSize:CGFloat = 11
    private let kSymbolFontSize:CGFloat = 25
    private let kBorderHeight:CGFloat = 1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let labelTitle:UILabel = UILabel()
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.isUserInteractionEnabled = false
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.font = UIFont.regular(size:kTitleFontSize)
        self.labelTitle = labelTitle
        
        let labelSymbol:UILabel = UILabel()
        labelSymbol.backgroundColor = UIColor.clear
        labelSymbol.translatesAutoresizingMaskIntoConstraints = false
        labelSymbol.isUserInteractionEnabled = false
        labelSymbol.textAlignment = NSTextAlignment.center
        labelSymbol.font = UIFont.bolder(size:kSymbolFontSize)
        self.labelSymbol = labelSymbol
        
        let border:VBorder = VBorder(color:UIColor.clear)
        self.border = border
        
        addSubview(labelTitle)
        addSubview(labelSymbol)
        addSubview(border)
        
        NSLayoutConstraint.bottomToBottom(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kTitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:labelSymbol,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override var isSelected:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    override var isHighlighted:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    //MARK: private
    
    private func hover()
    {
        if isSelected || isHighlighted
        {
            labelTitle.textColor = UIColor.black
            labelSymbol.textColor = UIColor.hyperBlue
            border.backgroundColor = UIColor.black
        }
        else
        {
            labelTitle.textColor = UIColor(white:0.8, alpha:1)
            labelSymbol.textColor = UIColor(white:0.92, alpha:1)
            border.backgroundColor = UIColor(white:0.8, alpha:1)
        }
    }
    
    //MARK: public
    
    func config(model:MSearchContentModeItem)
    {
        labelTitle.text = model.title
        labelSymbol.text = model.symbol
        hover()
    }
}
