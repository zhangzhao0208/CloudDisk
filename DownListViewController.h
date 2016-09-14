//
//  DownListViewController.h
//  CloudDisk
//
//  Created by suorui on 16/9/12.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "YYText.h"
#import "SRConst.h"
#import "CustomTopView.h"
#import "AdjustFontSizeView.h"
#import "BottomFileView.h"
#import "CatalogViewController.h"
#import "TotalModel.h"
#import "SearchBarView.h"
#import "LXAlertView.h"
#import "SearchBackgroundView.h"
#import "TransportListTableViewCell.h"
#import "HTTPRequestManager.h"
#import <UAProgressView/UAProgressView.h>
@interface DownListViewController : UIViewController

{
     NSMutableDictionary     *_downloaderManager;
}
@property(nonatomic,strong)UITableView*catalogTable;
@property(nonatomic,strong)NSMutableArray*catalogArray;
@property(nonatomic,strong)NSMutableArray*catal;
@property(nonatomic,assign)NSIndexPath* selectedIndexPath;
@property(nonatomic,assign)BOOL isCellOpen;
@property(nonatomic,assign)NSInteger recordOpenCellRow;
@property(nonatomic,strong)UISegmentedControl*transportSegment;
@property(nonatomic,strong)NSURLSessionDownloadTask*downLoadTask;
@property(nonatomic,strong)UAProgressView*progressView;

@end
