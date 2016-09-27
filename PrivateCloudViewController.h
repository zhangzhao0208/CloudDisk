//
//  PrivateCloudViewController.h
//  CloudDisk
//
//  Created by suorui on 16/9/8.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "YYText.h"
#import "SRConst.h"
#import "CustomTopView.h"
#import "AdjustFontSizeView.h"
#import "PublicCloudCatalogTableViewCell.h"
#import "BottomFileView.h"
#import "CatalogViewController.h"
#import "ToolTableViewCell.h"
#import "TotalModel.h"
#import "PublicCloudViewController.h"
#import "SearchBarView.h"
#import "LXAlertView.h"
#import "SearchBackgroundView.h"
#import "TransportListViewController.h"
@interface PrivateCloudViewController : UIViewController
{
    BottomFileView * bottomFileView;
    UIView * topView;
    UIView * moreOperatinView;
    UIView * recordMoreView;
    UIImageView*arrowImageView;
    SearchBackgroundView *searchBackgroundView;
    UIButton*lastOperationBtn;
}
@property(nonatomic,strong)UITableView*catalogTable;
@property(nonatomic,copy)NSMutableArray*publicListArray;
@property(nonatomic,copy)NSMutableArray*catal;
@property(nonatomic,assign)NSIndexPath* selectedIndexPath;
@property(nonatomic,assign)BOOL isCellOpen;
@property(nonatomic,assign)NSInteger recordOpenCellRow;
@property(nonatomic,strong)UIView*operationBackView;
@end
