import UIKit

class VHomeWordsCell:UICollectionViewCell
{
    weak var controller:CHome?
    weak var model:RModelHomeEntriesItem?
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func config(controller:CHome, model:RModelHomeEntriesItem)
    {
        self.controller = controller
        self.model = model
    }
}
