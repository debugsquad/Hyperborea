import UIKit

class VSpinner:UIImageView
{
    private let kAnimationDuration:TimeInterval = 2
    
    init()
    {
        super.init(frame:CGRect.zero)
        
        let images:[UIImage] = [
        ]
        
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        animationDuration = kAnimationDuration
        animationImages = images
        contentMode = UIViewContentMode.center
        startAnimating()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
