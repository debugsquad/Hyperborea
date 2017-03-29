import UIKit

class VSearchResultsFlow:UICollectionViewLayout
{
    private var layoutAttributes:[UICollectionViewLayoutAttributes]
    private var contentWidth:CGFloat
    private var contentHeight:CGFloat
    private let contentTop:CGFloat
    private let kCellHeight:CGFloat = 50
    
    init(contentTop:CGFloat)
    {
        contentWidth = 0
        contentHeight = 0
        layoutAttributes = []
        self.contentTop = contentTop
        
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
        
        var section:Int = 0
        var maxPositionX:CGFloat = 0
        var positionY:CGFloat = barHeight
        
        for row:MLinearEquationsProjectRow in model.rows
        {
            var item:Int = 0
            var positionX:CGFloat = 0
            
            for col:MLinearEquationsProjectRowItem in row.items
            {
                let indexPath:IndexPath = IndexPath(
                    item:item,
                    section:section)
                let colWidth:CGFloat = col.cellWidth
                let frame:CGRect = CGRect(
                    x:positionX,
                    y:positionY,
                    width:colWidth,
                    height:kCellHeight)
                
                item += 1
                positionX += colWidth
                
                let attributes:UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(
                    forCellWith:indexPath)
                attributes.frame = frame
                layoutAttributes.append(attributes)
            }
            
            if positionX > maxPositionX
            {
                maxPositionX = positionX
            }
            
            section += 1
            positionY += kCellHeight
        }
        
        contentWidth = maxPositionX
        contentHeight = positionY
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
