import UIKit

class VRecentCell:UICollectionViewCell
{
    private weak var label:UILabel!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        self.label = label
        
        addSubview(label)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func config(model:MRecentEntry)
    {
        
    }
}
