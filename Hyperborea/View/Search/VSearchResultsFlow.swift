import UIKit

class VSearchResultsFlow:UICollectionViewLayout
{
    private weak var controller:CSearch!
    private var layoutAttributes:[UICollectionViewLayoutAttributes]
    private var contentWidth:CGFloat
    private var contentHeight:CGFloat
    private let kContentBottom:CGFloat = 20
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
            
            let model:MSearchResults = controller.modelResults
        
        else
        {
            return
        }
        
        contentWidth = UIScreen.main.bounds.maxX
        let maxWidth:CGFloat = contentWidth - kMarginHorizontal
        var positionY:CGFloat = controller.viewSearch.barOptionsTop + kMarginVertical
        var positionX:CGFloat = kMarginHorizontal
        var maxCurrentY:CGFloat = 0
        var item:Int = 0
        
        for result:MSearchResultsItem in model.items
        {
            let indexPath:IndexPath = IndexPath(
                item:item,
                section:kSection)
            let cellWidth:CGFloat = result.cellWidth
            let cellHeight:CGFloat = result.cellHeight
            
            if positionX + cellWidth > maxWidth
            {
                positionX = kMarginHorizontal
                positionY += maxCurrentY + kMarginVertical
                maxCurrentY = 0
            }
            
            let frame:CGRect = CGRect(
                x:positionX,
                y:positionY,
                width:cellWidth,
                height:cellHeight)
            
            if cellHeight > maxCurrentY
            {
                maxCurrentY = cellHeight
            }
            
            item += 1
            positionX += cellWidth + kMarginHorizontal
            
            let attributes:UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(
                forCellWith:indexPath)
            attributes.frame = frame
            layoutAttributes.append(attributes)
        }
        
        contentHeight = positionY + maxCurrentY + kContentBottom
        controller.viewSearch.resultsHeight(resultsHeight:contentHeight)
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
        return false
    }
}
