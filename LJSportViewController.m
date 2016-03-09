//
//  LJSportViewController.m
//  SunFreeLander
//
//  Created by qianfeng on 16/3/8.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "LJSportViewController.h"

@interface LJSportViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
<<<<<<< HEAD

=======
{
    UILabel *naviItemTitle;
}
>>>>>>> RW-master
@end

@implementation LJSportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
<<<<<<< HEAD
    [self layoutNaviItem];
    
}

- (void)layoutNaviItem {

    
}

#pragma mark UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

=======
    [self initAll];
    [self layoutNaviItem];
    
}

- (void)initAll {
    naviItemTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
}

- (void)layoutNaviItem {
    
    
}

#pragma mark UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

>>>>>>> RW-master


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
