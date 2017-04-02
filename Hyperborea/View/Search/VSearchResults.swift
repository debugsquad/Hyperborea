import UIKit

class VSearchResults:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private var items:[MSearchResultsItem]?
    private weak var controller:CSearch!
    private weak var collectionView:VCollection!
    
    init(controller:CSearch)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let flow:VSearchResultsFlow = VSearchResultsFlow(
            controller:controller)
        
        let collectionView:VCollection = VCollection(
            flow:flow)
        collectionView.bounces = false
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VSearchResultsCell.self)
        self.collectionView = collectionView
        
        addSubview(collectionView)
        
        NSLayoutConstraint.equals(
            view:collectionView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MSearchResultsItem
    {
        let item:MSearchResultsItem = items![index.item]
        
        return item
    }
    
    //MARK: public
    
    func refresh()
    {
        items = controller.modelResults?.items
        collectionView.reloadData()
    }
    
    func changeOrientation()
    {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    //MARK: collectionView delegate
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        guard
        
            let count:Int = items?.count
        
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
