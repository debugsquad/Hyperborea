import UIKit

class VSearchResultsCell:UICollectionViewCell
{
    private let kCornerRadius:CGFloat = 10
    private let kBaseMarginHorizontal:CGFloat = 6
    private let kBaseMarginVertical:CGFloat = 3
    
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
            toView:self,
            margin:kBaseMarginVertical)
        NSLayoutConstraint.equalsHorizontal(
            view:baseView,
            toView:self,
            margin:kBaseMarginHorizontal)
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
