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
@interface TransportListViewController ()<UITableViewDelegate,UITableViewDataSource,BottomFileViewDelegate>


@end

@implementation TransportListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _catal =[NSMutableArray array];
    for (int a =0; a<10; a++) {
        TotalModel * totalModel =[TotalModel new];
        [_catal addObject:totalModel];
    }

     [self changeNavgationBarState];
    [self createSegmentControl];
    [self createPublicCloudTableView];
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
    
    ///Users/suorui/Desktop/CloudDisk/TransportListViewController.m:54:23: Assigning retained object to unsafe_unretained variable; object will be released after assignment
    NSArray*segmentArray =[NSArray arrayWithObjects:downloadList,uploadList,saveToAlbum,nil];
    _transportSegment =[[UISegmentedControl alloc]initWithItems:segmentArray];
    _transportSegment.tintColor = REB(244, 244, 244, 1);
    _transportSegment.frame = CGRectMake(10, 74, WIDTH-20, 40);
     NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:REB(163, 163, 163, 1),NSForegroundColorAttributeName,[UIFont systemFontOfSize:16],NSFontAttributeName ,nil];
    [_transportSegment setTitleTextAttributes:dic forState:UIControlStateNormal];
    NSDictionary *selectedDic =[NSDictionary dictionaryWithObjectsAndKeys:REB(65, 147, 248, 1) ,NSForegroundColorAttributeName,[UIFont systemFontOfSize:16],NSFontAttributeName ,nil];

     [_transportSegment setTitleTextAttributes:selectedDic forState:UIControlStateSelected];
    [_transportSegment addTarget:self action:@selector(changeSelecedSegment:) forControlEvents:UIControlEventValueChanged];
   
    [self.view addSubview:_transportSegment];
    
    
}

-(void)changeSelecedSegment:(UISegmentedControl*)segment
{
    switch (segment.selectedSegmentIndex) {
        case 0:
            
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;

        default:
            break;
    }
}
-(void)createPublicCloudTableView
{
    _catalogTable = [UITableView new];
    [self.view addSubview:_catalogTable];
    _catalogTable.delegate = self;
    _catalogTable.dataSource = self;
    [_catalogTable registerClass:[TransportListTableViewCell class] forCellReuseIdentifier:@"TransportListTableViewCell"];
    
    [_catalogTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        //        make.top.equalTo(topView.mas_bottom);
        make.top.offset(124);
        make.width.offset(WIDTH);
        make.bottom.offset(-49);
    }];
    UIView*backView =[UIView new];
    backView.backgroundColor =REB(240, 240, 240, 1);
    backView.frame = CGRectMake(0, 0, WIDTH, 10);
    _catalogTable.tableHeaderView = backView;
   
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _catalogArray.count+_catal.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TotalModel *totalModel =_catal[indexPath.row];
  
        TransportListTableViewCell*cell =[tableView dequeueReusableCellWithIdentifier:@"TransportListTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        totalModel.selectedRow = indexPath.row;
        
        cell.totalModel = totalModel;
        
        //展开cell;
    
        return cell;
        
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        NSLog(@"-++++++++-%ld",indexPath.row);
        NSString*str =[NSString stringWithFormat:@"省公司文件%ld",indexPath.row];
//        CatalogViewController *catalogViewController =[[CatalogViewController alloc]initWithFileName:str];
//        [self.navigationController pushViewController:catalogViewController animated:YES];
//        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
    
    
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
