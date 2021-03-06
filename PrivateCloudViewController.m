//
//  PrivateCloudViewController.m
//  CloudDisk
//
//  Created by suorui on 16/9/8.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import "PrivateCloudViewController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define REB(R,E,D,A) ([UIColor  colorWithRed:R/255.0 green:E/255.0 blue:D/255.0 alpha:A])
#define DOWNSINGLETION [DownloadManagerSingletion singletion]
#define USERD [NSUserDefaults standardUserDefaults]

@interface PrivateCloudViewController ()<UITableViewDelegate,UITableViewDataSource,BottomFileViewDelegate,SearchBackgroundViewDelegate>

@end

@implementation PrivateCloudViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self changeNavgationBarState];
    [self createSearchView];
    //    [self createTopView];
    [self createPublicCloudTableView];
    [self createBottomButtonView];
    [self createMoreOperationView];

}
-(void)changeNavgationBarState
{
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar
    .backgroundColor =[UIColor blackColor];
    self.title=privateCloud ;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20]};
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:privateCloud style:UIBarButtonItemStylePlain target:nil action:nil];
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
-(void)createSearchView
{
    
    __block PrivateCloudViewController*private = self;
    SearchBarView*searchBarView =[[SearchBarView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, 60)];
    searchBarView.addFolserBlock =^(){
      
        LXAlertView *alert=[[LXAlertView alloc] initWithTitle:@"新建文件夹" message:@"" cancelBtnTitle:@"取消" otherBtnTitle:@"确定" clickIndexBlock:^(NSInteger clickIndex) {
            NSLog(@"点击index====%ld",clickIndex);
        }];
        //alert.dontDissmiss=YES;
        //设置动画类型(默认是缩放)
        //_alert.animationStyle=LXASAnimationTopShake;
        [alert showLXAlertView];
        
    };
    
    searchBarView.searchBlock = ^{
      
        [UIView animateWithDuration:0.4 animations:^{
            self.navigationController.navigationBar.frame = CGRectMake(0, -64, WIDTH, 64);
//
            searchBackgroundView = [[SearchBackgroundView alloc]initWithFrame:private.view.bounds];
            searchBackgroundView.searchBackgroundViewDelegate =self;
            [private.view addSubview:searchBackgroundView];
        } completion:^(BOOL finished) {
              [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
            
        }];

       
    };
    
    [self.view addSubview:searchBarView];
}
-(void)removeSearchBackgroundView
{
    
//     self.navigationController.navigationBar.barTintColor = REB(22, 22, 22, 1);
    [UIView animateWithDuration:0.4 animations:^{
          [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        self.navigationController.navigationBar.frame = CGRectMake(0, 0, WIDTH, 64);
    } completion:^(BOOL finished) {
        
        [searchBackgroundView removeFromSuperview];
      
    }];

   
    
}

-(void)createPublicCloudTableView
{
    _catalogTable = [UITableView new];
    [self.view addSubview:_catalogTable];
    _catalogTable.delegate = self;
    _catalogTable.dataSource = self;
    [_catalogTable registerClass:[PublicCloudCatalogTableViewCell class] forCellReuseIdentifier:@"PublicCloudCatalogTableViewCell"];
    [_catalogTable registerClass:[ToolTableViewCell class] forCellReuseIdentifier:@"ToolTableViewCell"];
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
    //    self.selectedIndexPath=nil;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _publicListArray.count+_catal.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PublicListModel *totalModel =_publicListArray[indexPath.row];
    //    NSLog(@"--%@",_catal);
    if (totalModel.isFromToolCell==NO) {
        PublicCloudCatalogTableViewCell*cell =[tableView dequeueReusableCellWithIdentifier:@"PublicCloudCatalogTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        totalModel.selectedRow = indexPath.row;
//        NSLog(@"--%@",totalModel);
        cell.totalModel = totalModel;
        
        //展开cell;
        cell.insertBlock =^(NSInteger insertIndex){
    
            if (_isCellOpen==NO) {
                
                PublicListModel*insertTotalModel =[PublicListModel new];
                insertTotalModel.isFromToolCell=YES;
                [_publicListArray insertObject:insertTotalModel atIndex:insertIndex+1];
                
                NSIndexPath*insertIndexPath =[NSIndexPath indexPathForRow:insertIndex+1 inSection:0];
                [_catalogTable insertRowsAtIndexPaths:@[insertIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                _recordOpenCellRow = insertIndex+1;
                _isCellOpen=YES;
                
            }else
            {
                
                //移除数组中上次加入的对象,删除对应的cell
                [_publicListArray removeObjectAtIndex:_recordOpenCellRow];
                NSIndexPath*lastIndexPath =[NSIndexPath indexPathForRow:_recordOpenCellRow inSection:0];
                [_catalogTable deleteRowsAtIndexPaths:@[lastIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                
                //恢复旋转的按钮
                NSIndexPath*lastCellPath =[NSIndexPath indexPathForRow:_recordOpenCellRow-1 inSection:0];
                PublicCloudCatalogTableViewCell*cell=  [_catalogTable cellForRowAtIndexPath:lastCellPath];
                cell.catalogButton.transform = CGAffineTransformMakeRotation(0);
                //把上一个展开的cell的对象属性,恢复到未展开状态
                PublicListModel*lastTotalModel =[_publicListArray objectAtIndex:_recordOpenCellRow-1];
                
                lastTotalModel.selectedButton=NO;
                
                //让新的cell展开.
                PublicListModel*insertTotalModel =[PublicListModel new];
                insertTotalModel.isFromToolCell=YES;
                [_publicListArray insertObject:insertTotalModel atIndex:insertIndex+1];
                NSIndexPath*insertIndexPath =[NSIndexPath indexPathForRow:insertIndex+1 inSection:0];
                [_catalogTable insertRowsAtIndexPaths:@[insertIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                _recordOpenCellRow = insertIndex+1;
                
            }
            
            
        };
        
        //闭合cell
        cell.closeCellBlock =^(NSInteger insertIndex)
        {
            [_publicListArray removeObjectAtIndex:insertIndex+1];
            NSIndexPath*lastIndexPath =[NSIndexPath indexPathForRow:insertIndex+1 inSection:0];
            [_catalogTable deleteRowsAtIndexPaths:@[lastIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            _isCellOpen=NO;
            
            
        };
        
        
        return cell;
        
    }else
    {
        //获取当前下载的cell数据
        PublicListModel *toolTotalModel =_publicListArray[indexPath.row-1];
        ToolTableViewCell*cell =[tableView dequeueReusableCellWithIdentifier:@"ToolTableViewCell" forIndexPath:indexPath];
        toolTotalModel.selectedRow = indexPath.row-1;
       
        cell.totalModel = toolTotalModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.totalModel.tname =[NSString stringWithFormat:@"%ld",indexPath.row-1];
       
        
        return cell;
    }
    
}
+(NSData *)returnDataWithNSMutableArray:(NSMutableArray *)dict
{
    NSMutableData * data = [[NSMutableData alloc] init];
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:dict forKey:@"talkData"];
    [archiver finishEncoding];
    return data;
}
+(NSData *)returnDataWithNSDictionary:(NSMutableDictionary *)dict
{
    NSMutableData * data = [[NSMutableData alloc] init];
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:dict forKey:@"talkData"];
    [archiver finishEncoding];
    return data;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:[PublicCloudCatalogTableViewCell class]]) {
        NSLog(@"-++++++++-%ld",indexPath.row);
        NSString*str =[NSString stringWithFormat:@"省公司文件%ld",indexPath.row];
        CatalogViewController *catalogViewController =[[CatalogViewController alloc]initWithFileName:str];
        [self.navigationController pushViewController:catalogViewController animated:YES];
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
    
    
}

-(void)createBottomButtonView
{
    //    bottomFileView =[[BottomFileView alloc]initWithFrame:CGRectMake(0, HEIGHT-(HEIGHT*110.0f/1280.0f), WIDTH, HEIGHT*110.0f/1280.0f)];
    bottomFileView =[[BottomFileView alloc]initWithFrame:CGRectMake(0, HEIGHT-49, WIDTH, 49)];
    bottomFileView.BottomFileDelegate =self;
    
    [self.view addSubview:bottomFileView];
    
    
    
}
-(void)createMoreOperationView
{
    
    
    arrowImageView =[UIImageView new];
    arrowImageView.image = [UIImage imageNamed:@"menuarrow"];
    arrowImageView.transform = CGAffineTransformRotate(arrowImageView.transform, -M_PI);
    [self.view addSubview:arrowImageView];
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-60.0f*WIDTH/720.0f);
        make.width.offset(0);
        make.bottom.equalTo(bottomFileView.mas_top);
        make.height.offset(0);
    }];
    
    moreOperatinView =[UIView new];
    [self.view addSubview:moreOperatinView];
    //    moreOperatinView.backgroundColor =[UIColor redColor];
    moreOperatinView.clipsToBounds=YES;
    [moreOperatinView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.right.offset(-10);
        make.right.offset(-60.0f*WIDTH/720.0f);
        make.bottom.equalTo(arrowImageView.mas_top);
        make.width.offset(0);
        make.height.offset(0);
    }];
    UIImageView * bgImageView =[UIImageView new];
    UIImage *image =[UIImage imageNamed:@"menubg"];
    UIEdgeInsets edge=UIEdgeInsetsMake(10, 10, 20,10);
    //UIImageResizingModeStretch：拉伸模式，通过拉伸UIEdgeInsets指定的矩形区域来填充图片
    //UIImageResizingModeTile：平铺模式，通过重复显示UIEdgeInsets指定的矩形区域来填充图
    image= [image resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
    bgImageView.image=image;
    bgImageView.userInteractionEnabled=YES;
    //    bgImageView.backgroundColor =[UIColor blueColor];
    [moreOperatinView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(moreOperatinView);
        
    }];
    NSArray*titleArray =[NSArray arrayWithObjects:@"传输列表",@"移动到", @"重命名",  nil];
    UIButton*lastButton=nil;
    for (int i=0; i<3; i++) {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        //        button.backgroundColor =[UIColor blueColor];
        [bgImageView addSubview:button];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.tag = i+200;
        [button addTarget:self action:@selector(clickMoreOperationButton:) forControlEvents:UIControlEventTouchUpInside];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(bgImageView.mas_width);
            make.left.equalTo(bgImageView.mas_left);
            
            if (lastButton) {
                make.top.equalTo(lastButton.mas_bottom);
                make.height.equalTo(lastButton.mas_height);
            }else
            {
                make.top.equalTo(bgImageView.mas_top);
                
            }
            if (i==2) {
                make.bottom.equalTo(bgImageView.mas_bottom);
            }
            
        }];
        lastButton=button;
    }
}

-(void)changeMoreOperationViewPosition:(UIButton*)sender

{
    lastOperationBtn = sender;
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        [arrowImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(20);
            make.height.offset(10);
            
        }];
        [moreOperatinView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-10);
            //            make.bottom.equalTo(arrowImageView.mas_top);
            make.width.offset(180.0f*WIDTH/720.0f);
            make.height.offset(260.0f*HEIGHT/1280.0f);
            
        }];
        
        [self.view layoutIfNeeded];
    }];
    
}
-(void)removeMoreOperationView:(UIButton*)sender

{
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        
        [arrowImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.width.offset(0);
            make.height.offset(0);
        }];
        [moreOperatinView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-60.0f*WIDTH/720.0f);
            make.width.offset(0);
            make.height.offset(0);
            
        }];
        [self.view layoutIfNeeded];
    }];
    
}
-(void)clickRightButton
{
    
    UIWindow*window =[[UIApplication sharedApplication].delegate window ];
    PublicCloudViewController *publicCloudViewController = [PublicCloudViewController new];
    
    UINavigationController*publicNav =[[UINavigationController alloc]initWithRootViewController:publicCloudViewController];

    window.rootViewController = publicNav;
}

-(void)clickMoreOperationButton:(UIButton*)sender
{
    if (sender.tag==200) {
        
        lastOperationBtn.selected=NO;
        [UIView animateWithDuration:0.2 animations:^{
            
            [arrowImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.width.offset(0);
                make.height.offset(0);
            }];
            [moreOperatinView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.offset(-60.0f*WIDTH/720.0f);
                make.width.offset(0);
                make.height.offset(0);
                
            }];
            [self.view layoutIfNeeded];
            
//            if ([USERD objectForKey:@"inDownloadArray"]) {
//                DOWNSINGLETION.inDownloadArray= [PrivateCloudViewController returnDictionaryWithDataPath:[USERD objectForKey:@"inDownloadArray"]] ;
//            }
//            if ([USERD objectForKey:@"downloaderManager"]) {
//                
//                DOWNSINGLETION.downloaderManager= [PrivateCloudViewController returnNSMutableDictionaryWithDataPath:[USERD objectForKey:@"downloaderManager"]];
//            }
            //
////
          

            
            
            
            
        } completion:^(BOOL finished) {
            TransportListViewController *transportlistViewController =[TransportListViewController new];
            [self.navigationController pushViewController:transportlistViewController animated:YES];
            [self.view setNeedsUpdateConstraints];
            [self.view updateConstraintsIfNeeded];
        }];

        NSLog(@"传输列表");
    }
    
}
+(NSMutableArray *)returnDictionaryWithDataPath:(NSData *)data
{
    NSKeyedUnarchiver * unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSMutableArray * myDictionary = [unarchiver decodeObjectForKey:@"talkData"] ;
    [unarchiver finishDecoding];
    
    return myDictionary;
}
+(NSMutableDictionary *)returnNSMutableDictionaryWithDataPath:(NSData *)data
{
    NSKeyedUnarchiver * unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSMutableDictionary * myDictionary = [unarchiver decodeObjectForKey:@"talkData"] ;
    [unarchiver finishDecoding];
    
    return myDictionary;
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
