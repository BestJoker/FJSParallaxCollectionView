//
//  ViewController.m
//  FJSParallaxCollectionView
//
//  Created by 付金诗 on 16/6/24.
//  Copyright © 2016年 www.fujinshi.com. All rights reserved.
//

#import "ViewController.h"
#import "FJSModel.h"
#import "FJSParallaxCollectionViewCell.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"视觉差Demo";
    
    [self setupCustomousView];
    
    [self setupData];
    
}


- (void)setupCustomousView
{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.width * (47.f / 75.f));
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsZero;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[FJSParallaxCollectionViewCell class] forCellWithReuseIdentifier:@"FJSParallaxCollectionViewCell"];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FJSParallaxCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FJSParallaxCollectionViewCell" forIndexPath:indexPath];
    [cell getValueFromModel:[self.dataArray objectAtIndex:indexPath.item]];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    for (FJSParallaxCollectionViewCell * cell in [self.collectionView visibleCells]) {
        cell.cellOffSetY = [cell convertPoint:CGPointMake(cell.bounds.size.width * 0.5, cell.bounds.size.height * 0.5) toView:self.view].y;
    }
}

- (void)setupData
{
    NSMutableArray * imageNameArray = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 10; i++) {
        NSString * imageName = [NSString stringWithFormat:@"%ld.jpg",i];
        [imageNameArray addObject:imageName];
    }
    
    NSMutableArray * titleArray = [NSMutableArray arrayWithObjects:@"没有两凉茶和糖水",@"上海好评前4的手工作坊",@"不差钱的成都人都怎么玩",@"若你喜欢旧物 其实他们很美",@"台北隐秘小资地图",@"看个球啊 还不如看脸",@"用了18年时间挖了上千口井",@"他跑到了世界尽头去收集材料",@"放弃上亿的纽约时尚圈",@"电影宣发把钱花在哪了", nil];
    
    NSMutableArray * detailArray = [NSMutableArray arrayWithObjects:@"都不好好的在广州过夏天了",@"如果压力大 就来透透气",@"高逼格有愉快的耍店技能",@"8家复古店铺时光旅行",@"去台北只知道101",@"欧洲杯少女看球指南",@"他从6岁起就让上百万人喝上干净水",@"却不用一砖一瓦造起一座博物馆",@"90后姑娘只为难民设计衣裳",@"你至少也懂点吧", nil];
    
    
    self.dataArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i++) {
        FJSModel * model = [[FJSModel alloc] init];
        model.imageName = [imageNameArray objectAtIndex:i];
        model.title = [titleArray objectAtIndex:i];
        model.detail = [detailArray objectAtIndex:i];
        [self.dataArray addObject:model];
    }
    
    [self.collectionView reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
