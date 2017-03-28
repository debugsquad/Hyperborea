import UIKit

class VSearchResults:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CSearch!
    private weak var collectionView:VCollection!
    
    init(controller:CSearch)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let collectionView:VCollection = VCollection()
        self.collectionView = collectionView
        
        addSubview(collectionView)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MSearchResultsItem
    {
        let item:MSearchResultsItem = controller.modelResults!.items[index.item]
        
        return item
    }
    
    //MARK: collectionView delegate
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        guard
        
            let count:Int = controller.modelResults?.items.count
        
        else
        {
            return 0
        }
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MSearchResultsItem = modelAtIndex(index:indexPath)
        let cell:VSearchResultsCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VSearchResultsCell.reusableIdentifier,
            for:indexPath) as! VSearchResultsCell
        cell.config(model:item)
        
        return cell
    }
}
