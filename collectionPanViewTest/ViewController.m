//
//  ViewController.m
//  collectionPanViewTest
//
//  Created by ytz on 2018/1/24.
//  Copyright © 2018年 ytz. All rights reserved.
//

#import "ViewController.h"
#import "YTDragCollectionLayout.h"
@interface ViewController ()<YTDragCollectionLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) UIView *deleteView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.dataArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23"].mutableCopy;
//    if (@available(iOS 11, *)) {
//        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    }else{
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
//
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.view.frame =CGRectMake(0, 64, YScreenWidth, YScreenHeight-64);
//
//    YTDragCollectionLayout *collectionViewLayout = [[YTDragCollectionLayout alloc] init];
//    collectionViewLayout.minimumInteritemSpacing = 15;
//    collectionViewLayout.minimumLineSpacing = 5;
//    collectionViewLayout.itemSize = CGSizeMake(50, 54);
//    collectionViewLayout.delegate = self;
//
//    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:collectionViewLayout];
//    _collectionView.delegate = self;
//    _collectionView.dataSource = self;
//
//    _collectionView.backgroundColor = [UIColor whiteColor];
//    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
//    [self.view addSubview:_collectionView];
//
//    CGRect deleteRect = CGRectMake(0, self.view.frame.size.height, YScreenWidth, 50);
//    UIView *view  = [[UIView alloc] initWithFrame:deleteRect];
//    view.backgroundColor = [UIColor redColor];
//
//    self.deleteView = view;
//    [self.view addSubview:view];
    self.dataArray = @[].mutableCopy;
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *label = [cell viewWithTag:1000];
    if(label==nil) {
        label= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50,50)];
        label.text =@"wqwqwwqwqw";
        label.tag = 1000;
        [cell addSubview:label];
    }
    
    label.text = self.dataArray[indexPath.row];
    cell.backgroundColor = [UIColor greenColor];
    
    return cell;
}

- (void)yt_moveDataItem:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    id  object = self.dataArray[fromIndexPath.row];
    [self.dataArray removeObjectAtIndex:fromIndexPath.row];
    [self.dataArray insertObject:object atIndex:toIndexPath.row];

 //  [self.dataArray exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
}

- (void)yt_removeDataObjectAtIndex:(NSIndexPath *)index {
      [self.dataArray removeObjectAtIndex:index.row];
}

- (CGRect)yt_RectForDelete {

    return  CGRectMake(0, self.view.frame.size.height-50, YScreenWidth, 50);

}

- (BOOL)yt_canMoveItemInIndexPath:(NSIndexPath *)indexPath {

    return YES;
    
}

- (void)yt_didMoveToDeleteArea {
    self.deleteView.alpha = .5;
    [self.view bringSubviewToFront:self.deleteView];
}

- (void)yt_didLeaveToDeleteArea {
     self.deleteView.alpha = 1;
    
}

- (void)yt_willBeginGesture {
    [UIView animateWithDuration:0.4 animations:^{
        self.deleteView.frame = CGRectMake(self.deleteView.frame.origin.x, self.view.frame.size.height-self.deleteView.frame.size.height, self.deleteView.frame.size.width, self.deleteView.frame.size.height);
    }];
    
}

- (void)yt_didEndGesture {
    [UIView animateWithDuration:0.4 animations:^{
         self.deleteView.frame = CGRectMake(self.deleteView.frame.origin.x, self.view.frame.size.height, self.deleteView.frame.size.width, self.deleteView.frame.size.height);
    }];
}

- (UIView *)yt_moveMainView{
    return self.view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
