//
//  TransportListViewController.m
//  CloudDisk
//
//  Created by suorui on 16/9/9.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import "TransportListViewController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define REB(R,E,D,A) ([UIColor  colorWithRed:R/255.0 green:E/255.0 blue:D/255.0 alpha:A])
@interface TransportListViewController ()<UITableViewDelegate,UITableViewDataSource,BottomFileViewDelegate,UINavigationControllerDelegate>


@end

@implementation TransportListViewController


//-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    [viewController viewWillAppear:animated];
//}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_downListViewControl viewWillAppear:animated];  //tabbarController直接用selectedViewController更方便
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate=self;
     [self changeNavgationBarState];
    [self createSegmentControl];

}
-(void)changeNavgationBarState
{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar
    .backgroundColor =[UIColor blackColor];
    self.title=transportList;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20]};
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:transportList style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    UIButton*rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 30, 30);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"off"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.view.backgroundColor =[UIColor whiteColor];

    self.automaticallyAdjustsScrollViewInsets=NO;
    
}

-(void)createSegmentControl
{
  
    NSArray*segmentArray =[NSArray arrayWithObjects:downloadList,uploadList,saveToAlbum,nil];
    _transportSegment =[[UISegmentedControl alloc]initWithItems:segmentArray];
    _transportSegment.tintColor = REB(244, 244, 244, 1);
    _transportSegment.frame = CGRectMake(10, 74, WIDTH-20, 40);
    _transportSegment.selectedSegmentIndex = 0;
     NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:REB(163, 163, 163, 1),NSForegroundColorAttributeName,[UIFont systemFontOfSize:16],NSFontAttributeName ,nil];
    [_transportSegment setTitleTextAttributes:dic forState:UIControlStateNormal];
    NSDictionary *selectedDic =[NSDictionary dictionaryWithObjectsAndKeys:REB(65, 147, 248, 1) ,NSForegroundColorAttributeName,[UIFont systemFontOfSize:16],NSFontAttributeName ,nil];

     [_transportSegment setTitleTextAttributes:selectedDic forState:UIControlStateSelected];
    [_transportSegment addTarget:self action:@selector(changeSelecedSegment:) forControlEvents:UIControlEventValueChanged];
   
    [self.view addSubview:_transportSegment];
    _uploadListViewControl = [UploadListViewController new];
    [self.view addSubview:_uploadListViewControl.view];
    _downListViewControl =[DownListViewController new];
    [self.view addSubview:_downListViewControl.view];
    [self.view bringSubviewToFront:_downListViewControl.view];
    
}

-(void)changeSelecedSegment:(UISegmentedControl*)segment
{
    switch (segment.selectedSegmentIndex) {
        case 0:
            
            [self.view bringSubviewToFront:_downListViewControl.view];
            

            break;
        case 1:
            
            
            [self.view bringSubviewToFront:_uploadListViewControl.view];
            
            
            break;
        case 2:
           
            break;

        default:
            break;
    }
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
