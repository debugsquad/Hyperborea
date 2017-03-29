import UIKit

class VSearchResultsCell:UICollectionViewCell
{
    private let kCornerRadius:CGFloat = 12
    private let kBaseMargin:CGFloat = 1
    
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
        
        NSLayoutConstraint.equals(
            view:baseView,
            toView:self,
            margin:kBaseMargin)
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
