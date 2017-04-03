import UIKit

class VSearchResults:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private var model:MSearchResults?
    private weak var controller:CSearch!
    private weak var collectionView:VCollection!
    private let kAfterEnable:TimeInterval = 0.5
    
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
        let item:MSearchResultsItem = model!.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func refresh()
    {
        model = controller.modelResults
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
        
            let count:Int = model?.items.count
        
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
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        collectionView.isUserInteractionEnabled = false
        
        UIApplication.shared.keyWindow!.endEditing(true)
        let item:MSearchResultsItem = modelAtIndex(index:indexPath)
        controller.selectResults(resultItem:item)
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kAfterEnable)
        { [weak collectionView] in
            
            collectionView?.isUserInteractionEnabled = true
        }
    }
}
