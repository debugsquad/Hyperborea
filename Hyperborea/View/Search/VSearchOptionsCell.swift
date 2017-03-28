import UIKit

class VSearchOptionsCell:UICollectionViewCell
{
    private let kCornerRadius:CGFloat = 5
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.white
        layer.cornerRadius = kCornerRadius
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
