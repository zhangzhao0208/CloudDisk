//
//  CatalogViewController.m
//  CloudDisk
//
//  Created by suorui on 16/9/6.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import "CatalogViewController.h"
#import "Masonry.h"
#import "YYText.h"
#import "SRConst.h"
#import "CustomTopView.h"
#import "AdjustFontSizeView.h"
#import "PublicCloudCatalogTableViewCell.h"
#import "BottomFileView.h"
#import "CatalogViewController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define REB(R,E,D,A) ([UIColor  colorWithRed:R/255.0 green:E/255.0 blue:D/255.0 alpha:A])
#define USERD [NSUserDefaults standardUserDefaults]
@interface CatalogViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CatalogViewController

-(instancetype)initWithFileName:(NSString*)fileName
{
    self =[super init];
    if (self) {
        
        _fileName =fileName;
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=_fileName;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20]};
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:_fileName style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;

    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor =[UIColor whiteColor];
     self.automaticallyAdjustsScrollViewInsets=NO;
    [self createPublicCloudTableView];
    [self createBottomButtonView];
}

-(void)createPublicCloudTableView
{
    _catalogTable = [UITableView new];
    [self.view addSubview:_catalogTable];
    _catalogTable.delegate = self;
    _catalogTable.dataSource = self;
    [_catalogTable registerClass:[PublicCloudCatalogTableViewCell class] forCellReuseIdentifier:@"PublicCloudCatalogTableViewCell"];
    [_catalogTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        //        make.top.equalTo(topView.mas_bottom);
        make.top.offset(64);
        make.width.offset(WIDTH);
        make.bottom.offset(-HEIGHT*110.0f/1280.0f);
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _catalogArray.count+10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PublicCloudCatalogTableViewCell*cell =[tableView dequeueReusableCellWithIdentifier:@"PublicCloudCatalogTableViewCell" forIndexPath:indexPath];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString*str =[NSString stringWithFormat:@"省公司文件%ld",indexPath.row];
    CatalogViewController *catalogViewController =[[CatalogViewController alloc]initWithFileName:str];
    [self.navigationController pushViewController:catalogViewController animated:YES];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)createBottomButtonView
{
    BottomFileView * bottomFileView =[[BottomFileView alloc]initWithFrame:CGRectMake(0, HEIGHT-(HEIGHT*110.0f/1280.0f), WIDTH, HEIGHT*110.0f/1280.0f)];
    [self.view addSubview:bottomFileView];
    
    
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
