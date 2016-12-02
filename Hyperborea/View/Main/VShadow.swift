import UIKit

class VShadow:UIView
{
    private let kMaxAlpha:CGFloat = 0.5
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.black
        
        minAlpha()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func maxAlpha()
    {
        alpha = kMaxAlpha
    }
    
    func minAlpha()
    {
        alpha = 0
    }
}
