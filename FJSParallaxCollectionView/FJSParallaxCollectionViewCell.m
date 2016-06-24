//
//  FJSParallaxCollectionViewCell.m
//  FJSParallaxCollectionView
//
//  Created by 付金诗 on 16/6/24.
//  Copyright © 2016年 www.fujinshi.com. All rights reserved.
//

#import "FJSParallaxCollectionViewCell.h"
#define kCenterOffset 30.f

@interface FJSParallaxCollectionViewCell ()
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UIImageView * mainImageView;
@property (nonatomic,strong)UILabel * detailLabel;
@property (nonatomic,strong)UIView * coverView;
@end
@implementation FJSParallaxCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //一定要注意,这个属性非常重要,超出父视图的视图不会显示出来.
        self.clipsToBounds = YES;
        
        [self setupCustomousView];
        
        [self setupLayoutCustomousView];
        
    }
    return self;
}

- (void)setupCustomousView
{
    self.mainImageView = [UIImageView new];
    //设置图片的填充方式为填满,并且设置图片的大小超出cell本身,但是中心点居中.
    self.mainImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.mainImageView];
    
    self.coverView = [UIView new];
    self.coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    [self.contentView addSubview:self.coverView];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = 1;
    [self.contentView addSubview:self.titleLabel];
    
    
    self.detailLabel = [UILabel new];
    self.detailLabel.textAlignment = 1;
    self.detailLabel.textColor = [UIColor whiteColor];
    self.detailLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.detailLabel];
}


- (void)setupLayoutCustomousView
{
    [self.mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(self.contentView.bounds.size.height + 2 * kCenterOffset);
    }];
    
    [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView.mas_centerY).with.offset(-15);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView.mas_centerY).with.offset(18);
    }];
    
}


- (void)getValueFromModel:(FJSModel *)model
{
    self.titleLabel.text = model.title;
    self.detailLabel.text = model.detail;
    if (model.isDownload) {
        self.mainImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",model.imageName]];
    }else
    {
        self.mainImageView.alpha = 0.f;
        self.mainImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",model.imageName]];
        [UIView animateWithDuration:0.5 animations:^{
            self.mainImageView.alpha = 1.0f;
        } completion:^(BOOL finished) {
            model.isDownload = YES;
        }];
    }
}


-(void)setCellOffSetY:(CGFloat)cellOffSetY
{
    _cellOffSetY = cellOffSetY;
    //cellOffSetY 是这个cell的中心点距离屏幕window的相对位置. 在这里我采用中心点偏移来进行处理视距差效果.
    //当试图中心点变化范围 0 ~ 屏幕高度  而图片的中心点变化范围相对于cell的中心点 向上下移动kCenterOffset 距离 所以得出公式 如下.
    CGFloat centerOffSetY = (2 * kCenterOffset / ScreenHeight) * cellOffSetY - kCenterOffset;
    //为了确保滚动返回不超出图片的大小,导致出现图片衔接出现空白,要确保滚动到最大和最小值.
    centerOffSetY = MAX(-kCenterOffset, centerOffSetY);
    centerOffSetY = MIN(kCenterOffset, centerOffSetY);
    [self.mainImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView).with.offset(centerOffSetY);
        make.height.mas_equalTo(self.contentView.bounds.size.height + 2 * kCenterOffset);
    }];
}


@end
