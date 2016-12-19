//
//  InterviewKnowledgeViewController.m
//  BYMFinancing
//
//  Created by administrator on 2016/12/13.
//  Copyright © 2016年 mac. All rights reserved.
//  MesaSQLite数据库的简单使用方法
//  http://www.cnblogs.com/ChinaKingKong/p/4740912.html
#import "InterviewKnowledgeViewController.h"
#import "JQSQLManager.h"
#import "JQSqliteStudent.h"


@interface InterviewKnowledgeViewController ()

@end

@implementation InterviewKnowledgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view .backgroundColor = [UIColor whiteColor];
    [self InterviewKnowledge];
    //NSLog(@"%@",[self md5:@"123"]);
    
    [self readPaths];
    
    [self readPlistFile];
    
    [self openDatabase];
    
    [self setUpFMDB];
}

- (void)setUpFMDB {
    
    //注意：这里创建数据库，并不会打开数据库，和SQLite有点区别
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).firstObject;
    NSString *filePath = [path stringByAppendingPathComponent:@"FMDB.db"];
    FMDatabase *database = [FMDatabase databaseWithPath:filePath];
    
}



#pragma mark - 路径
- (void)readPaths{

    //虽然沙盒中有这么多文件夹，但是没有文件夹都不尽相同，都有各自的特性。所以在选择存放目录时，一定要认真选择适合的目录。“应用程序包”: 这里面存放的是应用程序的源文件，包括资源文件和可执行文件。
    NSString *path1 = [[NSBundle mainBundle] bundlePath];
    NSLog(@"path1 = %@",path1);

    //Documents: 最常用的目录，iTunes同步该应用时会同步此文件夹中的内容，适合存储重要数据。应用程序将其数据存储在这个文件夹下，基于NSUserDefaults的首选项的设置除外。
    NSString *path2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSLog(@"path2 = %@", path2);
    //Library/Caches: iTunes不会同步此文件夹，适合存储体积大，不需要备份的非重要数据。
    
    //Caches
    NSString *path3 = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSLog(@"path3 = %@", path3);
    
    //tmp： iTunes不会同步此文件夹，系统可能在应用没运行时就删除该目录下的文件，所以此目录适合保存应用中的一些临时文件，用完就删除。
    NSString *path4 = NSTemporaryDirectory();
    NSLog(@"path4 = %@", path4);
}

#pragma mark - plist

- (void)readPlistFile{
    //plist文件是将某些特定的类，通过XML文件的方式保存在目录中。
    
    //1.获得文件路径
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = [path stringByAppendingPathComponent:@"testFitst.plist"];
    NSLog(@"fileName = %@",fileName);
    
    //3.读取
    NSArray *result = [NSArray arrayWithContentsOfFile:fileName];
    
    
    NSArray *array = @[@"123",@"456",@"789"];
    if (MJQArrayIsEmpty(array)) {
        
        //2.存储
        [array writeToFile:fileName atomically:YES];

    }else {
        [@[@"212",@"32",@"7829"] writeToFile:fileName atomically:YES];

        
    }
    NSLog(@"%@", [NSArray arrayWithContentsOfFile:fileName]);
    
    //4.删除
    NSFileManager *fileMger = [NSFileManager defaultManager];
    NSString *testFirst = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"testFitst.plist"];
    
    //如果文件路径存在的话
    BOOL isExit = [fileMger fileExistsAtPath:testFirst];
    
    if (isExit) {
        NSError *err;
        //[fileMger removeItemAtPath:testFirst error:&err];
    }
    
    
    
    //NSUserDefaults
    //是专门用来保存应用程序的配置信息的，一般不要在偏好设置中保存其他数据。如果没有调用synchronize方法，系统会根据I/O情况不定时刻地保存到文件中。所以如果需要立即写入文件的就必须调用synchronize方法。偏好设置会将所有数据保存到同一个文件中。即preference目录下的一个以此应用包名来命名的plist文件。
    
}

//数据库：需要添加库文件：libsqlite3.dylib并导入主头文件
- (void)openDatabase {
    [self test01];
    
    [self test02];
    
    [self test03];
    
    [self test04];


}

#pragma mark - sqlite
- (void)test01
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 100, 160, 40);
    [button setTitle:@"insert" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor grayColor];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(insert:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)insert:(UIButton *)btn
{
    JQSqliteStudent *stu = [[JQSqliteStudent alloc]initWithName:@"ZiCheng" andAge:20 andPhone:@"13751755081" andID:0];
    
    BOOL isSuccess = [JQSQLManager addStudent:stu];
    if (isSuccess) {
        NSLog(@"成功");
        
    } else {
        NSLog(@"失败");
    }
    
}

- (void)test02
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 150, 160, 40);
    [button setTitle:@"select" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor grayColor];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)select:(UIButton *)btn
{
    NSArray *array = [JQSQLManager findAllStudent];
    for (JQSqliteStudent *stu in array) {
        
        NSLog(@"姓名:%@ 手机号:%@ ID:%d 年龄:%d", stu.name, stu.phone, stu.ID, stu.age);
    }
    
}

- (void)test03
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 200, 160, 40);
    [button setTitle:@"update" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor grayColor];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(update:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)update:(UIButton *)btn
{
    BOOL isSuccess = [JQSQLManager updateStudentName:@"sam" andAge:12 andPhone:@"13014452362" WhereIDIsEqual:1];
    if (isSuccess) {
        
        NSLog(@"修改成功");
    } else {
        
        NSLog(@"修改失败");
    }
    
}

- (void)test04
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 250, 160, 40);
    [button setTitle:@"delete" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor grayColor];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)delete:(UIButton *)btn
{
    
    BOOL isSuccess = [JQSQLManager deleteByID:1];
    if (isSuccess) {
        
        NSLog(@"删除成功");
    } else {
        
        NSLog(@"删除失败");
    }
    
}





















- (NSString *)md5:(NSString*)origString
{
    const char *original_str = [origString UTF8String];
    unsigned char result[32];
    CC_MD5(original_str, strlen(original_str), result);//调用md5
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++){
        [hash appendFormat:@"%02x", result[i]];
    }
    
    return hash;
}
//遍历去重、排序
- (void)InterviewKnowledge {
    
    //方法1
    NSArray *array = @[@"12-11", @"12-11", @"12-11", @"12-12", @"12-13", @"12-14"];
    NSMutableArray *resultArray = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSString *item in array) {
        if (![resultArray containsObject:item]) {
            [resultArray addObject:item];
        }
    }
    NSLog(@"resultArray: %@", resultArray);
    
    //方法2
    NSMutableDictionary *resultDict = [[NSMutableDictionary alloc] initWithCapacity:array.count];
    for (NSString *item in array) {
        [resultDict setObject:item forKey:item];
    }
    NSArray *resultArray2 = resultDict.allValues;
    NSLog(@"%@", resultArray2);
    
    //升序排序
    resultArray2 = [resultArray2 sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString *item1 = obj1;
        NSString *item2 = obj2;
        return [item1 compare:item2 options:NSLiteralSearch];
    }];
    NSLog(@"%@", resultArray);
    
    //方法3
    NSSet *set = [NSSet setWithArray:array];
    resultArray2 = [set allObjects];
    NSLog(@"%@", resultArray2);

}
/**
    简单描述一下XIB与Storyboards，说一下他们的优缺点
 优点：
 XIB：在编译前就提供了可视化界面，可以直接拖控件，也可以直接给控件添加约束，更直观一些，而且类文件中就少了创建控件的代码，确实简化不少，通常每个XIB对应一个类。
 Storyboard：在编译前提供了可视化界面，可拖控件，可加约束，在开发时比较直观，而且一个storyboard可以有很多的界面，每个界面对应一个类文件，通过storybard，可以直观地看出整个App的结构。

 缺点：
 XIB：需求变动时，需要修改XIB很大，有时候甚至需要重新添加约束，导致开发周期变长。XIB载入相比纯代码自然要慢一些。对于比较复杂逻辑控制不同状态下显示不同内容时，使用XIB是比较困难的。当多人团队或者多团队开发时，如果XIB文件被发动，极易导致冲突，而且解决冲突相对要困难很多。
 Storyboard：需求变动时，需要修改storyboard上对应的界面的约束，与XIB一样可能要重新添加约束，或者添加约束会造成大量的冲突，尤其是多团队开发。对于复杂逻辑控制不同显示内容时，比较困难。当多人团队或者多团队开发时，大家会同时修改一个storyboard，导致大量冲突，解决起来相当困难。

 Xcode 8 Instruments 学习（一）
 http://www.jianshu.com/p/92cd90e65d4c
 */


@end
