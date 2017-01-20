//
//  ManagerFinancialProductViewController.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/1.
//  Copyright © 2016年 mac. All rights reserved.
//
//http://www.cnblogs.com/graveliang/p/5749787.html  横竖屏

#import "ManagerFinancialProductViewController.h"
#import "AFNetworking.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ManagerFinancialProductViewController ()<NSURLSessionDownloadDelegate>

@property (nonatomic,strong) MPMoviePlayerController *moviePlayer;

@property (nonatomic,strong) NSURLSession *backgroundURLSession;

@property (nonatomic,strong) NSFileManager *manage;

@property (nonatomic,strong) NSString *docPath;

@property (nonatomic,strong) NSURLSessionDownloadTask *task;

@property (nonatomic,strong) NSData *fileData;

@property (nonatomic,assign) BOOL start;

@property (nonatomic,strong) UILabel *lab;

@property (nonatomic,strong) NSTimer *timer;


@end

@implementation ManagerFinancialProductViewController
{
    NSString *dataPath;
    NSString *tmpPath;
    NSString *docFilePath;
}

-(MPMoviePlayerController *)moviePlayer{
    if (!_moviePlayer) {
        NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString *filePath = [docPath stringByAppendingPathComponent:@"file.mp4"];
        NSURL *url=[NSURL fileURLWithPath:filePath];
        _moviePlayer=[[MPMoviePlayerController alloc]initWithContentURL:url];
        _moviePlayer.view.frame=CGRectMake(0, 0, self.view.frame.size.width, 200);
        _moviePlayer.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
    }
    return _moviePlayer;
}


- (NSString *)docPath
{
    if (!_docPath)
    {
        _docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    }
    return _docPath;
}

- (NSFileManager *)manage
{
    if (!_manage)
    {
        _manage = [NSFileManager defaultManager];
    }
    return _manage;
}

- (NSURLSession *)backgroundURLSession
{
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *identifier = @"background";
        NSURLSessionConfiguration* sessionConfig = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:identifier];
        session = [NSURLSession sessionWithConfiguration:sessionConfig
                                                delegate:self
                                           delegateQueue:[NSOperationQueue mainQueue]];
    });
    return session;
    
}

// TODO: delegete
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    
    NSString *filePath = [self.docPath stringByAppendingPathComponent:@"file.mp4"];
    [self.manage moveItemAtURL:location toURL:[NSURL fileURLWithPath:filePath] error:nil];
    [self.manage removeItemAtPath:dataPath error:nil];
    [self.manage removeItemAtPath:docFilePath error:nil];
    _fileData = nil;
    _start = NO;
    [_timer invalidate];
    NSLog(@"下载完成%@",filePath);
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    _start = YES;
    _lab.text = [NSString stringWithFormat:@"下载中,进度为%.2f",totalBytesWritten*100.0/totalBytesExpectedToWrite];
}




- (void)viewWillAppear:(BOOL)animated
{
//    [self.moviePlayer play];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view addSubview:self.moviePlayer.view];
//    [self.moviePlayer play];

    UIButton *start = [[UIButton alloc]initWithFrame:CGRectMake(60, 250, 40, 40)];
    [start setTitle:@"下载" forState:UIControlStateNormal];
    [start addTarget:self action:@selector(download) forControlEvents:UIControlEventTouchUpInside];
    start.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:start];
    
    UIButton *pause = [[UIButton alloc]initWithFrame:CGRectMake(160, 250, 40, 40)];
    [pause setTitle:@"暂停" forState:UIControlStateNormal];
    [pause addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    pause.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:pause];
    
    dataPath = [self.docPath stringByAppendingPathComponent:@"file.db"];
    
    _lab = [[UILabel alloc]initWithFrame:CGRectMake(40, 300, 200, 40)];
    _lab.backgroundColor = [UIColor orangeColor];
    _lab.text = @"下载进度";
    [self.view addSubview:_lab];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(downloadPause:) userInfo:nil repeats:YES];
}

- (void)pause
{
    
    [_task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        _fileData = resumeData;
        _task = nil;
        [resumeData writeToFile:dataPath atomically:YES];
        [self getDownloadFile];
    }];
}

- (void)download
{
    
    //http://sw.bos.baidu.com/sw-search-sp/software/48fb368daa41e/QQ_mac_5.2.0.dmg
    
    //https://ss2.baidu.com/y0s1hSulBw92lNKgpU_Z2jR7b2w6buu/data2/music/124756674/608296144000128.mp3?xcode=41168d0a4f0221090d9b8f0c677c76d2
    
    NSString *downloadURLString = @"http://sw.bos.baidu.com/sw-search-sp/software/48fb368daa41e/QQ_mac_5.2.0.dmg";
    NSURL* downloadURL = [NSURL URLWithString:downloadURLString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:downloadURL];
    
    _fileData = [NSData dataWithContentsOfFile:dataPath];
    
    if (_fileData){
        NSString *Caches = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
        [self.manage removeItemAtPath:Caches error:nil];
        [self MoveDownloadFile];
        _task = [self.backgroundURLSession downloadTaskWithResumeData:_fileData];
        
    }
    else
    {
        _task = [self.backgroundURLSession downloadTaskWithRequest:request];
    }
    
    _task.taskDescription = [NSString stringWithFormat:@"后台下载"];
    //执行resume保证开始了任务
    [_task resume];
    
    
}


//暂停下载,获取文件指针和缓存文件
- (void)downloadPause:(NSString *)fileName
{
    if (!_start)
    {
        return;
    }
    
    NSLog(@"%s",__func__);
    [_task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        _fileData = resumeData;
        _task = nil;
        [resumeData writeToFile:dataPath atomically:YES];
        [self getDownloadFile];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //做完保存操作之后让他继续下载
            if (_fileData)
            {
                _task = [self.backgroundURLSession downloadTaskWithResumeData:_fileData];
                [_task resume];
            }
        });
    }];
}

//获取系统生成的文件
- (void)getDownloadFile
{
    //调用暂停方法后,下载的文件会从下载文件夹移动到tmp文件夹
    NSArray *paths = [self.manage subpathsAtPath:NSTemporaryDirectory()];
    NSLog(@"%@",paths);
    for (NSString *filePath in paths)
    {
        if ([filePath rangeOfString:@"CFNetworkDownload"].length>0)
        {
            tmpPath = [self.docPath stringByAppendingPathComponent:filePath];
            NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:filePath];
            //tmp中的文件随时有可能给删除,移动到安全目录下防止被删除
            [self.manage copyItemAtPath:path toPath:tmpPath error:nil];
            
            //建议创建一个plist表来管理,可以通过task的response的***name获取到文件名称,kvc存储或者直接建立数据库来进行文件管理,不然文件多了可能会管理混乱;
        }
    }
}

//讲道理这个和上面的应该封装下
- (void)MoveDownloadFile
{
    NSArray *paths = [self.manage subpathsAtPath:_docPath];
    
    for (NSString *filePath in paths)
    {
        if ([filePath rangeOfString:@"CFNetworkDownload"].length>0)
        {
            docFilePath = [_docPath stringByAppendingPathComponent:filePath];
            NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:filePath];
            //反向移动
            [self.manage copyItemAtPath:docFilePath toPath:path error:nil];
            
            //建议创建一个plist表来管理,可以通过task的response的***name获取到文件名称,kvc存储或者直接建立数据库来进行文件管理,不然文件多了可能会管理混乱;
        }
    }
    NSLog(@"%@,%@",paths,[self.manage subpathsAtPath:NSTemporaryDirectory()]);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    NSLog(@"%s", __func__);
    
}




/**


- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector             = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val                  = orientation;
        // 从2开始是因为0 1 两个参数已经被selector和target占用
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}


- (BOOL)shouldAutorotate{
    return NO;
}


-(void) viewDidAppear:(BOOL) animated{
    [super viewDidAppear:animated];
}

-(void) viewDidDisappear:(BOOL) animated{
    [super viewDidAppear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view .backgroundColor = [UIColor whiteColor];
    self.title = @"K线图";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 250, 200, 40);
    [button setTitle:@"竖屏" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor grayColor];
    [button addTarget:self action:@selector(button01) forControlEvents:UIControlEventAllEvents];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(10, 150, 200, 40);
    [button2 setTitle:@"横屏" forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor grayColor];
    [button2 addTarget:self action:@selector(button02) forControlEvents:UIControlEventAllEvents];
    [button2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:button2];
    
}

- (void)button02
{
    [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
}

- (void)button01{
    [self interfaceOrientation:UIInterfaceOrientationPortrait];
}




*/



@end
