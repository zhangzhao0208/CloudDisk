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
#define DOWNSINGLETION [DownloadManagerSingletion singletion]
#define USERD [NSUserDefaults standardUserDefaults]
@interface DownListViewController ()<UITableViewDelegate,UITableViewDataSource,BottomFileViewDelegate,FileDownloadManagerDelegate>


@end

@implementation DownListViewController

- ( void )dealloc
{
    

}


-(void)viewWillAppear:(BOOL)animated
{
   
    NSLog(@"--rr");
//    [_catalogTable reloadData];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//       
//            for (TotalModel*totalModel in DOWNSINGLETION.inDownloadArray) {
//                FileDownloadManager *fileD = [[DownloadManagerSingletion singletion].downloaderManager objectForKey: totalModel.tname];
//                NSLog(@"===%@",totalModel);
//                fileD.file = totalModel;
//                [fileD startBackgroundDown];
//                
//            }
//        
//        
//    });
    DOWNSINGLETION.currentViewIsDownloadView=NO;

}
-(void)viewWillDisappear:(BOOL)animated
{
   
    
//    
    
  


}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    DOWNSINGLETION.currentViewIsDownloadView=YES;
//    _fileButtonDownState =[DOWNSINGLETION.inDownloadArray mutableCopy];
    
    _fileButtonDownState =[NSMutableArray array];
    self.view.backgroundColor =[UIColor whiteColor];
    self.view.frame = CGRectMake(0, 124, WIDTH, HEIGHT-124);
    
    [self createPublicCloudTableView];
    [self createDownloadAllFileButton];
}

-(void)createDownloadAllFileButton
{
    downloadAllFile =[UIButton buttonWithType:UIButtonTypeCustom];
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


#pragma mark 表视图
-(void)createPublicCloudTableView
{
    
//     _downloaderManager = [[NSMutableDictionary alloc] initWithCapacity:0];
    _catalogTable = [UITableView new];
    [self.view addSubview:_catalogTable];
    _catalogTable.delegate = self;
    _catalogTable.dataSource = self;
    _catalogTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_catalogTable registerClass:[TransportListTableViewCell class] forCellReuseIdentifier:@"TransportListTableViewCell"];
    
    [_catalogTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        //        make.top.equalTo(topView.mas_bottom);
        make.top.offset(50);
        make.width.offset(WIDTH);
        make.bottom.offset(-49);
    }];
    
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (DOWNSINGLETION.downloadOverArray.count==0||DOWNSINGLETION.inDownloadArray.count==0) {
        
        return 1;
    }else if (DOWNSINGLETION.downloadOverArray.count==0&&DOWNSINGLETION.inDownloadArray.count==0)
    {
        return 0;
    }
    
    else
    {
        return 2;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
    
        if (DOWNSINGLETION.inDownloadArray.count==0) {
            
            return DOWNSINGLETION.downloadOverArray.count;
        }else
        {
            return DOWNSINGLETION.inDownloadArray.count;
        }
        
    }else
    {
       return DOWNSINGLETION.downloadOverArray.count;
    }
    

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
            
        if (DOWNSINGLETION.inDownloadArray.count!=0) {
             PublicListModel *totalModel =DOWNSINGLETION.inDownloadArray[indexPath.row];
             
            TransportListTableViewCell*cell =[tableView dequeueReusableCellWithIdentifier:@"TransportListTableViewCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
//            totalModel.selectedRow = indexPath.row;
            
            cell.totalModel = totalModel;
            cell.fileManagerButton.file = totalModel;
            
            //给button关联自己的下载器
            cell.fileManagerButton.fileDownloader = [DOWNSINGLETION.downloaderManager objectForKey:totalModel.name];
            
            cell.fileManagerButton.tag = indexPath.row;
            [cell.fileManagerButton addTarget:self action:@selector(downloadButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//              [cell.fileManagerButton addObserver:self forKeyPath:@"downloadState" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)(cell.fileManagerButton)];
            NSLog(@"222---++%@",totalModel);
            //设置button状态
            if ([FileDownloadManager  isDownloadFinish:totalModel]) {
                //在下载文件夹下存在，说明已经下载完毕
                cell.fileManagerButton.downloadState = ButtonComplete;

            }
            
            
            else if ([FileDownloadManager isFileDownloading:totalModel]){
                //在临时文件夹下存在，说明下了一部分
                NSLog(@"333---++%@",totalModel.name);
                
                FileDownloadManager *fileD = [DOWNSINGLETION.downloaderManager objectForKey:totalModel.name];
                fileD.fileDownloadManagerDelegate = self;
                NSLog(@"444---++%@",totalModel.name);
                
                if ([fileD isDownloading]) {
                    //正在下载
                    cell.fileManagerButton.downloadState = ButtonDownloading;
                    [_fileButtonDownState addObject:cell.fileManagerButton];
                }else{
                    //暂停
                    cell.fileManagerButton.downloadState = ButtonPause;
                    
            
                }
            }
            
          
            
               return cell;

        }else
        {
            PublicListModel *totalModel =DOWNSINGLETION.downloadOverArray[indexPath.row];
            //    totalModel.tname =[NSString stringWithFormat:@"%ld",indexPath.row];
          
            TransportListTableViewCell*cell =[tableView dequeueReusableCellWithIdentifier:@"TransportListTableViewCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            totalModel.selectedRow = indexPath.row;
            cell.totalModel = totalModel;
            cell.fileManagerButton.file = totalModel;
            //给button关联自己的下载器
            cell.fileManagerButton.tag = indexPath.row;
           
            return cell;
 
        }
       
        //    totalModel.tname =[NSString stringWithFormat:@"%ld",indexPath.row];
        

    }else
    {
        PublicListModel *totalModel =DOWNSINGLETION.downloadOverArray[indexPath.row];
        //    totalModel.tname =[NSString stringWithFormat:@"%ld",indexPath.row];
        NSLog(@"111---++%@",totalModel.name);
        TransportListTableViewCell*cell =[tableView dequeueReusableCellWithIdentifier:@"TransportListTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        totalModel.selectedRow = indexPath.row;
        cell.totalModel = totalModel;
        cell.fileManagerButton.file = totalModel;
        //给button关联自己的下载器
         cell.fileManagerButton.downloadState = ButtonComplete;
        cell.fileManagerButton.tag = indexPath.row;
        [cell.fileManagerButton addTarget:self action:@selector(downloadButtonClick:) forControlEvents:UIControlEventTouchUpInside];
         return cell;
    }
    //    if ([FileDownloadManager  isDownloadFinish:totalModel]) {
//        //在下载文件夹下存在，说明已经下载完毕
//        cell.fileManagerButton.downloadState = ButtonComplete;
//    }
//    else if ([FileDownloadManager isFileDownloading:totalModel]){
//        //在临时文件夹下存在，说明下了一部分
//        FileDownloadManager *fileD = [_downloaderManager objectForKey:totalModel.tname];
//        if ([fileD isDownloading]) {
//            //正在下载
//            cell.fileManagerButton.downloadState = ButtonDownloading;
//        }else{
//            //暂停
//            cell.fileManagerButton.downloadState = ButtonPause;
//        }
//    }
//    

    
    
    
   
    
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView*headerView =[UIView new];
    headerView.backgroundColor = REB(240, 240, 240, 1);
    UILabel*headLabel =[UILabel new];
    [headerView addSubview:headLabel];
    headLabel.backgroundColor =  REB(240, 240, 240, 1);
    headLabel.textAlignment = NSTextAlignmentLeft;
    [headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(5);
        make.left.offset(10);
        make.bottom.offset(-5);
        make.right.offset(-10);
    }];
    headLabel.textColor = REB(122, 122, 122, 1);
    if (section==0) {
        
        if (DOWNSINGLETION.inDownloadArray.count!=0) {
             headLabel.text = inDownload;
        }else
        {
             headLabel.text = downloadOver;
        }
        
        return headerView;
    }else
    {
         headLabel.text = downloadOver;
        return headerView;
    }
    
   
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    NSLog(@"-++++++++-%ld",indexPath.row);
//
     NSString*str =[NSString stringWithFormat:@"省公司文件%ld",indexPath.row];
    CatalogViewController *catalogViewController =[[CatalogViewController alloc]initWithFileName:str];
    [self.navigationController pushViewController:catalogViewController animated:YES];
    

    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
// 必须写的方法，和editActionsForRowAtIndexPath配对使用，里面什么不写也行
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
// 添加自定义的侧滑功能
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 添加一个删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        NSLog(@"删除按钮");
        if (indexPath.section==0) {
            [_inDownloadArray removeObjectAtIndex:indexPath.row];
        }else
        {
            [_downloadOverArray removeObjectAtIndex:indexPath.row];
        }
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        NSIndexSet*indexSet =[NSIndexSet indexSetWithIndex:indexPath.section ];
        [_catalogTable reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
 
    }];
    
    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"置顶" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        NSLog(@"置顶按钮");
    }];
   
    return @[deleteRowAction,topRowAction];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
    
    
}

#pragma mark 点击下载按钮
-(void)downloadButtonClick:(FileManagerButton*)sender
{
    PublicListModel *file = [DOWNSINGLETION.inDownloadArray objectAtIndex:sender.tag];
    FileDownloadManager *fileD = [DOWNSINGLETION.downloaderManager objectForKey: file.name];
    if (!fileD) {
        fileD = [[FileDownloadManager alloc] initWithFile:file];
        fileD.fileDownloadManagerDelegate = self;
        [DOWNSINGLETION.downloaderManager setObject:fileD forKey: file.name];
    }
    
    //创建下载器时，需要给button设置关联的下载器
    sender.fileDownloader = fileD;
    [fileD checkNet];
//    NSLog(@"000---%@",file);
    switch (sender.downloadState) {
//        case ButtonNormal:
//        {
//            //普通状态，开始下载
//            sender.downloadState = ButtonDownloading;
//            [fileD startDownload];
//            [downloadAllFile setTitle:allFilePauseDownload forState:UIControlStateNormal];
//            [_fileButtonDownState addObject:sender];
//            
//        }
//            break;
        case ButtonDownloading:
        {
            //正在下载状态，暂停状态
            file.isEnterDownloadControl=NO;
            [fileD cancelDownload];
//            [fileD suspendDownload];
            sender.downloadState = ButtonPause;
            [_fileButtonDownState removeObject:sender];
            if (_fileButtonDownState.count==0) {
                [downloadAllFile setTitle:allFileBeginDownload forState:UIControlStateNormal];
            }
        }
            break;
        case ButtonPause:
        {
            //暂停状态，继续下载
            sender.downloadState = ButtonDownloading;
         
                file.isEnterDownloadControl=YES;
            [fileD startDownload];
            [_fileButtonDownState addObject:sender];
            [downloadAllFile setTitle:allFilePauseDownload forState:UIControlStateNormal];
        }
            break;
        case ButtonComplete:
        {
            //完成状态，查看文件
            file.isEnterDownloadControl=NO;
             [_fileButtonDownState removeObject:sender];
            if (_fileButtonDownState.count==0) {
                [downloadAllFile setTitle:allFileBeginDownload forState:UIControlStateNormal];
            }

                NSLog(@"--打开文件");
        }
            break;
            
        default:
            break;
    }
    
}

-(void)clickDownloadAllFile:(UIButton*)sender
{
    
    if (sender.titleLabel.text==allFilePauseDownload) {
        
        _fileButtonPasueState = [_fileButtonDownState mutableCopy];
        [sender setTitle:allFileBeginDownload forState:UIControlStateNormal];
        for (PublicListModel*totalModel in DOWNSINGLETION.inDownloadArray) {
            NSLog(@"111----%@",totalModel);
   
            FileDownloadManager *fileD = [DOWNSINGLETION.downloaderManager objectForKey: totalModel.name];
            [fileD cancelDownload];
            
        }
        for (FileManagerButton *button in _fileButtonDownState) {
            button.downloadState=ButtonPause;
        }

        [_fileButtonDownState removeAllObjects];
       
    }else
    {
        [sender setTitle:allFilePauseDownload forState:UIControlStateNormal];
        for (PublicListModel*totalModel in DOWNSINGLETION.inDownloadArray) {
            NSLog(@"222----%@",totalModel);
            

            FileDownloadManager *fileD = [DOWNSINGLETION.downloaderManager objectForKey: totalModel.name];
                [fileD startDownload];
            
           
        }
        for (FileManagerButton *button in _fileButtonPasueState) {
            button.downloadState=ButtonDownloading;
              [_fileButtonDownState addObject:button];
        }
        
      
        

        


    }
   
    
       NSLog(@"全部下载");
}
-(void)removeInDownloadCell:(PublicListModel*)totalModel
{
    
    [_catalogTable reloadData];
}

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
//{
//    NSLog(@"---%@",object);
//    FileManagerButton*recordButton =(FileManagerButton*)object;
//    
//   
//}
//

+(NSData *)returnDataWithDictionary:(NSMutableArray *)dict
{
    NSMutableData * data = [[NSMutableData alloc] init];
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:dict forKey:@"talkData"];
    [archiver finishEncoding];
    return data;
}
//路径文件转dictonary
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

-(void)updateCatalogTable
{
     [_catalogTable reloadData];
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
