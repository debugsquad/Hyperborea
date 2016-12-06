import UIKit

class VHomeWordsHeader:UICollectionReusableView
{
    private weak var controller:CHome?
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.genericBlue
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func config(controller:CHome)
    {
        self.controller = controller
    }
}
