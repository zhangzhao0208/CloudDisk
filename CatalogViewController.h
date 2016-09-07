//
//  CatalogViewController.h
//  CloudDisk
//
//  Created by suorui on 16/9/6.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatalogViewController : UIViewController

{
    UIView * topView;
}
@property(nonatomic,strong)UITableView*catalogTable;
@property(nonatomic,copy)NSArray*catalogArray;
@property(nonatomic,copy)NSString *fileName;
-(instancetype)initWithFileName:(NSString*)fileName;
@end
