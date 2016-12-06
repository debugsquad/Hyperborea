import UIKit

class VHomeWordsHeader:UICollectionReusableView
{
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
}
