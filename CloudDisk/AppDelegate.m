//
//  AppDelegate.m
//  CloudDisk
//
//  Created by suorui on 16/9/5.
//  Copyright © 2016年 suorui. All rights reserved.
//

///Users/suorui/Desktop/CloudDisk/CloudDisk.xcodeproj Applications using launch screen files and targeting iOS 7.1 and earlier need to also include a launch image in an asset catalog.

#import "AppDelegate.h"
#import "PublicCloudViewController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define REB(R,E,D,A) ([UIColor  colorWithRed:R/255.0 green:E/255.0 blue:D/255.0 alpha:A])
#define DOWNSINGLETION [DownloadManagerSingletion singletion]
#define USERD [NSUserDefaults standardUserDefaults]
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window =[[UIApplication sharedApplication].delegate window];
    [self.window makeKeyWindow];
    PublicCloudViewController * publicCloudViewController = [PublicCloudViewController new];
    UINavigationController*publicNav =[[UINavigationController alloc]initWithRootViewController:publicCloudViewController];
       self.window.rootViewController = publicNav;
    NSData*downloadOverArrayData = [USERD objectForKey:@"downloadOverArray"];
    DOWNSINGLETION.downloadOverArray = [AppDelegate returnNSMutableArrayWithDataPath:downloadOverArrayData];
    NSData*inDownloadArrayData = [USERD objectForKey:@"inDownloadArray"];
    DOWNSINGLETION.inDownloadArray = [AppDelegate returnNSMutableArrayWithDataPath:inDownloadArrayData];
    
    NSData*downloaderManagerData = [USERD objectForKey:@"downloaderManager"];
    DOWNSINGLETION.downloaderManager = [AppDelegate returnNSMutableDictionaryWithDataPath:downloaderManagerData];
    return YES;
}

- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)())completionHandler
{
    self.backgroundSessionCompletionHandler = completionHandler;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
         NSLog(@"%@,我是：",[NSThread currentThread]);
        for (TotalModel*totalModel in DOWNSINGLETION.inDownloadArray) {
            if (totalModel.isEnterDownloadControl==YES) {
                FileDownloadManager *fileD = [[DownloadManagerSingletion singletion].downloaderManager objectForKey: totalModel.tname];
                fileD.file = totalModel;
                [fileD cancelDownload];
                
            }else
            {
                break;
            }
            
        }

    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
      
        for (TotalModel*totalModel in DOWNSINGLETION.inDownloadArray) {
            if (totalModel.isEnterDownloadControl==YES) {
                FileDownloadManager *fileD = [[DownloadManagerSingletion singletion].downloaderManager objectForKey: totalModel.tname];
                fileD.file = totalModel;
                [fileD startBackgroundDown];
                
            }else
            {
                break;
            }
            
        }

        
    });
    

    
   
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}
+(NSData *)returnDataWithNSMutableDictionary:(NSMutableDictionary *)dict
{
    NSMutableData * data = [[NSMutableData alloc] init];
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:dict forKey:@"talkData"];
    [archiver finishEncoding];
    return data;
}

+(NSData *)returnDataWithNSMutableArray:(NSMutableArray *)dict
{
    NSMutableData * data = [[NSMutableData alloc] init];
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:dict forKey:@"talkData"];
    [archiver finishEncoding];
    return data;
}
//路径文件转dictonary
+(NSMutableArray *)returnNSMutableArrayWithDataPath:(NSData *)data
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

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    
    for (TotalModel*totalModel in DOWNSINGLETION.inDownloadArray) {
        
        if (totalModel.isEnterDownloadControl==YES) {
            FileDownloadManager *fileD = [DOWNSINGLETION.downloaderManager objectForKey: totalModel.tname];
            fileD.file = totalModel;
            [fileD cancelBackgroundDownload];
            
        }else
        {
            break;
        }
        
    }

  
   
   
    
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
  
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        for (TotalModel*totalModel in DOWNSINGLETION.inDownloadArray) {
//            
//            if (totalModel.isEnterDownloadControl==YES) {
//                FileDownloadManager *fileD = [DOWNSINGLETION.downloaderManager objectForKey: totalModel.tname];
//                fileD.file = totalModel;
//                [fileD startDownload];
//                
//            }else
//            {
//                break;
//            }
//            
//        }
//
//    });
    
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSLog(@"%@,我是：",[NSThread currentThread]);
        NSData*downloadOverArrayData = [AppDelegate returnDataWithNSMutableArray:DOWNSINGLETION.downloadOverArray];
        [USERD setObject:downloadOverArrayData forKey:@"downloadOverArray"];
        NSData*inDownloadArrayData = [AppDelegate returnDataWithNSMutableArray:DOWNSINGLETION.inDownloadArray];
        [USERD setObject:inDownloadArrayData forKey:@"inDownloadArray"];
        
        NSData*downloaderManagerData = [AppDelegate returnDataWithNSMutableDictionary:DOWNSINGLETION.downloaderManager ];
        [USERD setObject:downloaderManagerData forKey:@"downloaderManager"];
        
    });

    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.searchingsoft.CloudDisk" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CloudDisk" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CloudDisk.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
