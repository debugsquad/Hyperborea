import UIKit

class VSearchResultsCell:UICollectionViewCell
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
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
