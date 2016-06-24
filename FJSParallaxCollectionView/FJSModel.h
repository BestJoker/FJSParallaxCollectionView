//
//  FJSModel.h
//  FJSParallaxCollectionView
//
//  Created by 付金诗 on 16/6/24.
//  Copyright © 2016年 www.fujinshi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FJSModel : NSObject
@property (nonatomic,copy)NSString * imageName;
@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * detail;
@property (nonatomic,assign)BOOL isDownload;/**< 用来模拟加载过的图片 */
@end
