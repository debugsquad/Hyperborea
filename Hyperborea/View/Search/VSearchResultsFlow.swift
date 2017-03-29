import UIKit

class VSearchResultsFlow:UICollectionViewLayout
{
    private weak var controller:CSearch!
    private var layoutAttributes:[UICollectionViewLayoutAttributes]
    private var contentWidth:CGFloat
    private var contentHeight:CGFloat
    private let kContentBottom:CGFloat = 20
    private let kCellHeight:CGFloat = 32
    private let kMarginHorizontal:CGFloat = 10
    private let kMarginVertical:CGFloat = 10
    private let kSection:Int = 0
    
    init(controller:CSearch)
    {
        contentWidth = 0
        contentHeight = 0
        layoutAttributes = []
        self.controller = controller
        
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func prepare()
    {
        super.prepare()
        
        layoutAttributes = []
        
        guard
            
            let model:MSearchResults = controller.modelResults,
            let collectionView:UICollectionView = self.collectionView
        
        else
        {
            return
        }
        
        contentWidth = collectionView.bounds.maxX
        let maxWidth:CGFloat = contentWidth - kMarginHorizontal
        var positionY:CGFloat = controller.viewSearch.kBarMaxHeight + controller.viewSearch.kOptionsHeight + kMarginVertical
        var positionX:CGFloat = kMarginHorizontal
        var item:Int = 0
        
        for result:MSearchResultsItem in model.items
        {
            let indexPath:IndexPath = IndexPath(
                item:item,
                section:kSection)
            let cellWidth:CGFloat = result.cellWidth
            
            if positionX + cellWidth > maxWidth
            {
                positionX = kMarginHorizontal
                positionY += kCellHeight + kMarginVertical
            }
            
            let frame:CGRect = CGRect(
                x:positionX,
                y:positionY,
                width:cellWidth,
                height:kCellHeight)
            
            item += 1
            positionX += cellWidth + kMarginHorizontal
            
            let attributes:UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(
                forCellWith:indexPath)
            attributes.frame = frame
            layoutAttributes.append(attributes)
        }
        
        contentHeight = positionY + kContentBottom
        controller.viewSearch.resultsHeight(height:contentHeight)
    }
    
    override var collectionViewContentSize:CGSize
    {
        get
        {
            let size:CGSize = CGSize(
                width:contentWidth,
                height:contentHeight)
            
            return size
        }
    }
    
    override func layoutAttributesForElements(in rect:CGRect) -> [UICollectionViewLayoutAttributes]?
    {
        var attributes:[UICollectionViewLayoutAttributes]?
        
        for layoutAttribute:UICollectionViewLayoutAttributes in layoutAttributes
        {
            let frame:CGRect = layoutAttribute.frame
            
            if frame.intersects(rect)
            {
                if attributes == nil
                {
                    attributes = []
                }
                
                attributes!.append(layoutAttribute)
            }
        }
        
        return attributes
    }
    
    override func layoutAttributesForItem(at indexPath:IndexPath) -> UICollectionViewLayoutAttributes?
    {
        for layoutAttribute:UICollectionViewLayoutAttributes in layoutAttributes
        {
            if layoutAttribute.indexPath == indexPath
            {
                return layoutAttribute
            }
        }
        
        return nil
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds:CGRect) -> Bool
    {
        return true
    }
}
