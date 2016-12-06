import UIKit

class VHomeWords:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CHome!
    private weak var collectionView:UICollectionView!
    private var model:RModelHomeEntries?
    private let kInsetTop:CGFloat = 100
    private let kInsetBottom:CGFloat = 100
    
    convenience init(controller:CHome)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, insetForSectionAt section:Int) -> UIEdgeInsets
    {
        guard
        
            let model:RModelHomeEntries = self.model
            
        else
        {
            return UIEdgeInsets.zero
        }
        
        let insets:UIEdgeInsets
        
        if model.items.count > 0
        {
            insets = UIEdgeInsets(
                top:kInsetTop,
                left:0,
                bottom:kInsetBottom,
                right:0)
        }
        else
        {
            insets = UIEdgeInsets.zero
        }
        
        return insets
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        guard
        
            let count:Int = model?.items.count
        
        else
        {
            return 0
        }
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        
    }
}
