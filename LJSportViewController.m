//
//  LJSportViewController.m
//  SunFreeLander
//
//  Created by qianfeng on 16/3/8.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "LJSportViewController.h"
#import "CoverView.h"
#import "Masonry.h"
#import "MMDrawerController.h"

@interface LJSportViewController ()/*<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>*/
{
    UILabel *naviItemTitleLb;
    CoverView *coverView;
    NSArray *arrModel1;
    NSArray *arrModel2;
   
}
@end

@implementation LJSportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.LJSportCollectionView.backgroundColor = [UIColor whiteColor];
    [self initAll];
    [self layoutNaviItem];
    
}

- (void)initAll {
    naviItemTitleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    naviItemTitleLb.textAlignment = NSTextAlignmentCenter;
    coverView = [[CoverView alloc] initWithFrame:self.view.frame];
    arrModel1 = @[@"xingzhe_sporttype_cycling_highlight",@"xingzhe_sporttype_run_highlight",@"xingzhe_sporttype_walk_highlight"];
    arrModel2 = @[@"xingzhe_sporttype_cycling",@"xingzhe_sporttype_run",@"xingzhe_sporttype_walk"];
}

- (void)layoutNaviItem {
    UINavigationItem *item = self.navigationItem;
    item.titleView = naviItemTitleLb;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    naviItemTitleLb.text = @"行者";
    UIBarButtonItem *itemBarLeft = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_biking"] style:UIBarButtonItemStyleDone target:self action:@selector(itemBarLeftClick)];
    item.leftBarButtonItem = itemBarLeft;
    
    UIBarButtonItem *itemBarRightOne = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"camera"] style:UIBarButtonItemStyleDone target:self action:@selector(itemBarRightOneClick)];
    UIBarButtonItem *itemBarRightTwo = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"morebutton"] style:UIBarButtonItemStyleDone target:self action:@selector(itemBarRightTwoClick)];
    item.rightBarButtonItems = @[itemBarRightTwo,itemBarRightOne];
}

- (void)itemBarLeftClick {
    
    [self.tabBarController.view addSubview:coverView];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width*0.65, 50)];
    
    backView.center = CGPointMake(self.view.frame.size.width*0.35, 100);
    backView.backgroundColor = [UIColor whiteColor];
    [coverView addSubview:backView];

    for (int i = 1; i < 3; i++) {
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(i*backView.frame.size.width/3, 0, 1, backView.frame.size.height)];
        lb.backgroundColor = [UIColor grayColor];
        [backView addSubview:lb];
    }
    
    for (int i = 0; i < 3; i++) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*(backView.frame.size.width/3), 0, backView.frame.size.width/3, backView.frame.size.height)];
        [btn addTarget:self action:@selector(btnNaviLeftClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setShowsTouchWhenHighlighted:YES];
        [backView addSubview:btn];
        btn.tag = i+1;
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        imgView.image = [UIImage imageNamed:arrModel1[i]];
        imgView.center = CGPointMake((i+0.5)*(backView.frame.size.width/3), btn.frame.size.height/2);
        [backView addSubview:imgView];
        imgView.tag = i+11;
    }
}

- (void)btnNaviLeftClick:(UIButton *)btn {
    UIImageView *imgView = (UIImageView *)[coverView viewWithTag:btn.tag+10];
    imgView.image = [UIImage imageNamed:arrModel2[btn.tag-1]];
    
    [coverView removeFromSuperview];
}

- (void)itemBarRightOneClick {
    
}

- (void)itemBarRightTwoClick {
    
}

#pragma mark UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
