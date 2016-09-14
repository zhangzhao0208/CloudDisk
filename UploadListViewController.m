//
//  UploadListViewController.m
//  CloudDisk
//
//  Created by suorui on 16/9/13.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import "UploadListViewController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define REB(R,E,D,A) ([UIColor  colorWithRed:R/255.0 green:E/255.0 blue:D/255.0 alpha:A])
@interface UploadListViewController ()

@end

@implementation UploadListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor whiteColor];
    self.view.frame = CGRectMake(0, 124, WIDTH, HEIGHT-124);
    
    UIWebView*we =[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 200)];
    we.backgroundColor =[UIColor redColor];
    [self.view addSubview:we];
    [we loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    

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
