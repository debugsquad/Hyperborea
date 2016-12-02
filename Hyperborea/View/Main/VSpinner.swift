import UIKit

class VSpinner:UIImageView
{
    private let kAnimationDuration:TimeInterval = 2
    
    init()
    {
        super.init(frame:CGRect.zero)
        
        let images:[UIImage] = [
            #imageLiteral(resourceName: "assetLoader0"),
            #imageLiteral(resourceName: "assetLoader1"),
            #imageLiteral(resourceName: "assetLoader2"),
            #imageLiteral(resourceName: "assetLoader3"),
            #imageLiteral(resourceName: "assetLoader4"),
            #imageLiteral(resourceName: "assetLoader5"),
            #imageLiteral(resourceName: "assetLoader5"),
            #imageLiteral(resourceName: "assetLoader6"),
            #imageLiteral(resourceName: "assetLoader7"),
            #imageLiteral(resourceName: "assetLoader8"),
            #imageLiteral(resourceName: "assetLoader9"),
            #imageLiteral(resourceName: "assetLoader0")
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
