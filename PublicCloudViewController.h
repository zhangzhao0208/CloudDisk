//
//  PublicCloudViewController.h
//  CloudDisk
//
//  Created by suorui on 16/9/5.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TotalModel.h"

@interface PublicCloudViewController : UIViewController


{
   
}
@property(nonatomic,strong)UITableView*catalogTable;
@property(nonatomic,copy)NSMutableArray*catalogArray;
@property(nonatomic,copy)NSMutableArray*catal;
@property(nonatomic,assign)NSIndexPath* selectedIndexPath;
@property(nonatomic,assign)BOOL isCellOpen;

@end
