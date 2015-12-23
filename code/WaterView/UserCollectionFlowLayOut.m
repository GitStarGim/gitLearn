//
//  UserFlowLayOut.m
//
//  Created by 龚丁禧 on 15/10/31.
//  Copyright © 2015年 xiangchao. All rights reserved.
//
#define numColumns 2

#import "UserFlowLayOut.h"

@interface UserFlowLayOut()

@property (nonatomic)  CGFloat maxHeight;

@end

@implementation UserFlowLayOut


-(void)prepareLayout
{
    [super prepareLayout];
    CGFloat height_even = 0 , height_odd = 0;
    NSIndexPath *indexPath;
    NSInteger section = 0;
    NSInteger numItems = [self.collectionView numberOfItemsInSection:section];
    for(NSInteger item = 0; item < numItems; item++){
        indexPath = [NSIndexPath indexPathForItem:item inSection: section];
        UICollectionViewLayoutAttributes* currentItemAttributes = [super layoutAttributesForItemAtIndexPath: indexPath];
        CGRect f = currentItemAttributes.frame;
        if (item % 2) {
            height_odd += f.size.height + 9  ;
        } else {
            height_even += f.size.height + 9;
        }
    }
    
    self.maxHeight = height_even > height_odd ? height_even : height_odd;
}

- (CGSize)collectionViewContentSize {
    
    CGFloat width = self.collectionView.frame.size.width;
    CGFloat height = self.maxHeight + 10;
    self.itemSize = CGSizeMake(width,  height);
    return CGSizeMake(width, height);

}


- (NSArray *)layoutAttributesForElementsInRect: (CGRect)rect
{
    NSMutableArray *layoutAttributes = [NSMutableArray array];
    NSArray* attributesToReturn = [super layoutAttributesForElementsInRect:rect];
    for (UICollectionViewLayoutAttributes* attributes in attributesToReturn)
    {
        if (nil == attributes.representedElementKind)
        {
            NSIndexPath* indexPath = attributes.indexPath;
            attributes.frame = [self layoutAttributesForItemAtIndexPath:indexPath].frame;
            /*
            if (CGRectIntersectsRect(rect, attributes.frame)) {
                [layoutAttributes addObject: attributes];
            }
             */
        }
    }
    
    return attributesToReturn;
}

- (NSArray *)indexPathsOfItemsInRect:(CGRect)rect
{
    NSMutableArray *indexPaths;
    
    NSIndexPath *indexPath;
    NSInteger section = 0;
    NSInteger numItems = [self.collectionView numberOfItemsInSection:section];
    for(NSInteger item = 0; item < numItems; item++){
        indexPath = [NSIndexPath indexPathForItem:item inSection: section];
        UICollectionViewLayoutAttributes* currentItemAttributes = [self layoutAttributesForItemAtIndexPath: indexPath];
        CGRect f = currentItemAttributes.frame;
        NSLog(@"rect.origin x= %f, y = %f, w = %f, h = %f", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
        NSLog(@"f.origin    x= %f, y = %f, w = %f, h = %f", f.origin.x, f.origin.y, f.size.width, f.size.height);
        if (CGRectIntersectsRect(rect, f)){
            [indexPaths addObject: indexPath];
        }
    }
    
    return indexPaths;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes* currentItemAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    if (indexPath.item < numColumns){
        CGRect f = currentItemAttributes.frame;
        f.origin.y = 5;
        currentItemAttributes.frame = f;
        return currentItemAttributes;
    }

    NSIndexPath* ipPrev = [NSIndexPath indexPathForItem:indexPath.item-numColumns inSection:indexPath.section];
    CGRect fPrev = [self layoutAttributesForItemAtIndexPath:ipPrev].frame;
    CGFloat YPointNew = fPrev.origin.y + fPrev.size.height + 9;
    CGRect f = currentItemAttributes.frame;
    f.origin.y = YPointNew;
    currentItemAttributes.frame = f;
    
    //NSLog(@"row = %li, x = %f, y = %f, w = %f, h = %f", (long)indexPath.row, f.origin.x, f.origin.y, f.size.width, f.size.height);
    return currentItemAttributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
