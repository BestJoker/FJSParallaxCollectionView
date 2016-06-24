//
//  FJSParallaxCollectionViewCell.h
//  FJSParallaxCollectionView
//
//  Created by 付金诗 on 16/6/24.
//  Copyright © 2016年 www.fujinshi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJSModel.h"
@interface FJSParallaxCollectionViewCell : UICollectionViewCell
- (void)getValueFromModel:(FJSModel *)model;
@property (nonatomic,assign)CGFloat cellOffSetY;/**< cell相对于window的便宜量x */
@end
