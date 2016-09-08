//
//  PublicCloudViewController.h
//  CloudDisk
//
//  Created by suorui on 16/9/5.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TotalModel.h"
#import "Masonry.h"
#import "YYText.h"
#import "SRConst.h"
#import "CustomTopView.h"
#import "AdjustFontSizeView.h"
#import "PublicCloudCatalogTableViewCell.h"
#import "BottomFileView.h"
#import "CatalogViewController.h"
#import "ToolTableViewCell.h"
#import "PrivateCloudViewController.h"
@interface PublicCloudViewController : UIViewController


{
    BottomFileView * bottomFileView;
    UIView * topView;
    UIView * moreOperatinView;
    UIView * recordMoreView;
    UIImageView*arrowImageView;
    
    
}
@property(nonatomic,strong)UITableView*catalogTable;
@property(nonatomic,copy)NSMutableArray*catalogArray;
@property(nonatomic,copy)NSMutableArray*catal;
@property(nonatomic,assign)NSIndexPath* selectedIndexPath;
@property(nonatomic,assign)BOOL isCellOpen;
@property(nonatomic,assign)NSInteger recordOpenCellRow;
@end
