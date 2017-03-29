import UIKit

class VSearchResultsCell:UICollectionViewCell
{
    private let kCornerRadius:CGFloat = 10
    private let kBaseMarginHorizontal:CGFloat = 5
    private let kBaseMarginVertical:CGFloat = 2
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let baseView:UIView = UIView()
        baseView.backgroundColor = UIColor.cartesianBlue
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.clipsToBounds = true
        baseView.isUserInteractionEnabled = false
        baseView.layer.cornerRadius = kCornerRadius
        
        addSubview(baseView)
        
        NSLayoutConstraint.equalsVertical(
            view:baseView,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:baseView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func config(model:MSearchResultsItem)
    {
        
    }
}
