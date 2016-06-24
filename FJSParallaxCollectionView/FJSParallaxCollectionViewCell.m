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
        
        self.clipsToBounds = YES;
        
        [self setupCustomousView];
        
        [self setupLayoutCustomousView];
        
    }
    return self;
}

- (void)setupCustomousView
{
    self.mainImageView = [UIImageView new];
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
    CGFloat centerOffSetY = (2 * kCenterOffset / ScreenHeight) * cellOffSetY - kCenterOffset;
    centerOffSetY = MAX(-kCenterOffset, centerOffSetY);
    centerOffSetY = MIN(kCenterOffset, centerOffSetY);
    [self.mainImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView).with.offset(centerOffSetY);
        make.height.mas_equalTo(self.contentView.bounds.size.height + 2 * kCenterOffset);
    }];
}


@end
