import UIKit

class VSearchResultsCell:UICollectionViewCell
{
    private weak var label:UILabel!
    private weak var baseView:UIView!
    private let kCornerRadius:CGFloat = 7
    private let kBaseMargin:CGFloat = 1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let baseView:UIView = UIView()
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.clipsToBounds = true
        baseView.isUserInteractionEnabled = false
        baseView.layer.cornerRadius = kCornerRadius
        self.baseView = baseView
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.center
        self.label = label
        
        addSubview(baseView)
        addSubview(label)
        
        NSLayoutConstraint.equals(
            view:baseView,
            toView:self,
            margin:kBaseMargin)
        NSLayoutConstraint.equals(
            view:label,
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
            baseView.backgroundColor = UIColor.cartesianBlue
            label.textColor = UIColor.white
        }
        else
        {
            baseView.backgroundColor = UIColor(white:0.97, alpha:1)
            label.textColor = UIColor.black
        }
    }
    
    //MARK: public
    
    func config(model:MSearchResultsItem)
    {
        label.attributedText = model.name
        hover()
    }
}
