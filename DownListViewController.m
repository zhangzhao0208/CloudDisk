//
//  DownListViewController.m
//  CloudDisk
//
//  Created by suorui on 16/9/12.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import "DownListViewController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define REB(R,E,D,A) ([UIColor  colorWithRed:R/255.0 green:E/255.0 blue:D/255.0 alpha:A])
@interface DownListViewController ()<UITableViewDelegate,UITableViewDataSource,BottomFileViewDelegate,HTTPRequestManagerDelegate>


@end

@implementation DownListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _catal =[[NSMutableArray alloc]init];
    for (int a =0; a<10; a++) {
        TotalModel * totalModel =[TotalModel new];
        [_catal addObject:totalModel];
    }
    
    
    self.view.backgroundColor =[UIColor whiteColor];
    self.view.frame = CGRectMake(0, 124, WIDTH, HEIGHT-124);
    [self createDownloadAllFileButton];
    [self createPublicCloudTableView];
//    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:nil userInfo:nil repeats:YES];
    
    
}

-(void)c
{
      NSLog(@"=======%ld",_catal.count);
}

-(void)createDownloadAllFileButton
{
    UIButton*downloadAllFile =[UIButton buttonWithType:UIButtonTypeCustom];
    [downloadAllFile setTitle:allFilePauseDownload forState:UIControlStateNormal];
    [downloadAllFile setTitleColor:REB(84,84,84, 1) forState:UIControlStateNormal];
    downloadAllFile.layer.cornerRadius=5;
    downloadAllFile.clipsToBounds=YES;
    downloadAllFile.layer.borderColor = REB(219, 219, 219, 1).CGColor;
    downloadAllFile.layer.borderWidth = 1;
    [downloadAllFile addTarget:self action:@selector(clickDownloadAllFile:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:downloadAllFile];
    [downloadAllFile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(10);
        make.right.offset(-10);
        make.height.offset(40);
 
    }];
    
}

-(void)createPublicCloudTableView
{
    
     _downloaderManager = [[NSMutableDictionary alloc] initWithCapacity:0];
    _catalogTable = [UITableView new];
    [self.view addSubview:_catalogTable];
    _catalogTable.delegate = self;
    _catalogTable.dataSource = self;
    [_catalogTable registerClass:[TransportListTableViewCell class] forCellReuseIdentifier:@"TransportListTableViewCell"];
    
    [_catalogTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        //        make.top.equalTo(topView.mas_bottom);
        make.top.offset(50);
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
    cell.fileManagerButton.file = totalModel;
    
    //给button关联自己的下载器
    cell.fileManagerButton.fileDownloader = [_downloaderManager objectForKey:totalModel.tname];
    
    cell.fileManagerButton.tag = indexPath.row;
    [cell.fileManagerButton addTarget:self action:@selector(downloadButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置button状态
    if ([FileDownloadManager  isDownloadFinish:totalModel]) {
        //在下载文件夹下存在，说明已经下载完毕
        cell.fileManagerButton.downloadState = ButtonComplete;
    }
    else if ([FileDownloadManager isFileDownloading:totalModel]){
        //在临时文件夹下存在，说明下了一部分
        FileDownloadManager *fileD = [_downloaderManager objectForKey:totalModel.tname];
        if ([fileD isDownloading]) {
            //正在下载
            cell.fileManagerButton.downloadState = ButtonDownloading;
        }else{
            //暂停
            cell.fileManagerButton.downloadState = ButtonPause;
        }
    }else{
        cell.fileManagerButton.downloadState = ButtonNormal;
    }

    
    return cell;
    
    
}

-(void)downloadButtonClick:(FileManagerButton*)sender
{
    TotalModel *file = [_catal objectAtIndex:sender.tag];
      file.tname =[NSString stringWithFormat:@"%ld",sender.tag];
    FileDownloadManager *fileD = [_downloaderManager objectForKey: file.tname];
    if (!fileD) {
        fileD = [[FileDownloadManager alloc] initWithFile:file];
      
        
        [_downloaderManager setObject:fileD forKey: file.tname];
    }
    
    //创建下载器时，需要给button设置关联的下载器
    sender.fileDownloader = fileD;
    
    switch (sender.downloadState) {
        case ButtonNormal:
        {
            //普通状态，开始下载
            sender.downloadState = ButtonDownloading;
            [fileD startDownload];
            
        }
            break;
        case ButtonDownloading:
        {
            //正在下载状态，暂停状态
            sender.downloadState = ButtonPause;
            [fileD cancelDownload];
        }
            break;
        case ButtonPause:
        {
            //暂停状态，继续下载
            sender.downloadState = ButtonDownloading;
            [fileD continueDown];
        }
            break;
        case ButtonComplete:
        {
            //完成状态，查看文件
            NSLog(@"--");
        }
            break;
            
        default:
            break;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"-++++++++-%ld",indexPath.row);
//    NSString*str =[NSString stringWithFormat:@"省公司文件%ld",indexPath.row];
    //        CatalogViewController *catalogViewController =[[CatalogViewController alloc]initWithFileName:str];
    //        [self.navigationController pushViewController:catalogViewController animated:YES];
    //
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
    
    
}
-(void)changeProgressViewProgress:(NSProgress *)customProgress
{
    NSLog(@"---..>>>>%lld=>>>>>%lld",customProgress.completedUnitCount, customProgress.totalUnitCount);
    
    dispatch_async(dispatch_get_main_queue()
                   , ^{
                       _progressView.progress = 1.0*customProgress.completedUnitCount/ customProgress.totalUnitCount;
                       
                   });
    
}

-(void)clickDownloadAllFile:(UIButton*)sender
{
    NSLog(@"全部下载");
    
    
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
