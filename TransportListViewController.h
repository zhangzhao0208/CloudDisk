//
//  TransportListViewController.h
//  CloudDisk
//
//  Created by suorui on 16/9/9.
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
#import "DownListViewController.h"
#import "UploadListViewController.h"

@interface TransportListViewController : UIViewController
@property(nonatomic,strong)UITableView*catalogTable;
@property(nonatomic,strong)NSMutableArray*catalogArray;
@property(nonatomic,strong)NSMutableArray*catal;
@property(nonatomic,assign)NSIndexPath* selectedIndexPath;
@property(nonatomic,assign)BOOL isCellOpen;
@property(nonatomic,assign)NSInteger recordOpenCellRow;
@property(nonatomic,strong)UISegmentedControl*transportSegment;
@property(nonatomic,strong)DownListViewController*downListViewControl;
@property(nonatomic,strong)UploadListViewController*uploadListViewControl;
@end
