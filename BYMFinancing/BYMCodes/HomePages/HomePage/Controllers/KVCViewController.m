//
//  KVCViewController.m
//  BYMFinancing
//
//  Created by administrator on 2016/12/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "KVCViewController.h"
#import "Student.h"
#import "Course.h"
@interface KVCViewController ()

@property(nonatomic,strong)Student *student;
@end

@implementation KVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self testKVCOfSimple];         //简单测试下KVC
    
    [self testKVCOfValueForKeyPath];
    
    [self testKVCOfOther];
    
    [self testKVCOfSet];
    
    [self testKVCOfArray];
    
    
    [self testKVO];                 //简单测试下KVO
    

}

/** KVC 初识
 *  Student.m文件也没有实现,name属性没有加property
 *  原来的访问方法就访问不了name属性了
 *  用kvc就可以了
 *  注意：Terminating app due to uncaught exception 'NSUnknownKeyException', reason: '[<Student 0x127e99270> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key name1.'
    key值必须与 属性的名称一样，否则会出现上述错误
 */
- (void)testKVCOfSimple {
    Student *student = [[Student alloc]init];
    [student setValue:@"张三" forKey:@"name"];
    NSString *name = [student valueForKey:@"name"];
    NSLog(@"test result ：%@",name);

}

/**
 *  valueForKeyPath
 *  Terminating app due to uncaught exception 'NSUnknownKeyException', reason: '[<Student 0x13470de20> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key course.courseName.'

 *  Terminating app due to uncaught exception 'NSUnknownKeyException', reason: '[<Student 0x1003f3da0> valueForUndefinedKey:]: this class is not key value coding-compliant for the key course.'

 */
- (void)testKVCOfValueForKeyPath{
    Student *student = [[Student alloc]init];
    [student setValue:@"李四" forKey:@"name"];
    NSString *name = [student valueForKey:@"name"];
    NSLog(@"test result student.name：%@",name);
    
    Course *course = [[Course alloc]init];
    [course setValue:@"IT课程" forKey:@"courseName"];
    NSString *courseName = [course valueForKey:@"courseName"];
    NSLog(@"test result course.courseName：%@",courseName);
    
    // TODO: 注意：必须加上 这行代码 否则 下面输出的会为null
    [student setValue:course forKey:@"course"];
    
    //也可以这样存储
    [student setValue:@"数学课" forKeyPath:@"course.courseName"];
    NSLog(@"课程名：%@",[student valueForKeyPath:@"course.courseName"]);
    
}

/**
 *  自动封装基本数据类型
 *  用NSString*类型设置的属性值@"88"，而我们的属性是NSInteger类型的，存取都没有问题
 */
- (void)testKVCOfOther {
    Student *student = [[Student alloc]init];
    [student setValue:@"88" forKeyPath:@"point"];
    NSString *point = [student valueForKey:@"point"];
    NSLog(@"分数:%@", point);
}

/**
 *  测试集合
 *
 */
- (void)testKVCOfSet {

    Student *student = [[Student alloc]init];
    [student setValue:@"alice" forKey:@"name"];
    NSString *name = [student valueForKey:@"name"];
    NSLog(@"test result student.name：%@",name);
    

    Student *student1 = [[Student alloc]init];
    [student1 setValue:@"78" forKeyPath:@"point"];

    Student *student2 = [[Student alloc]init];
    [student2 setValue:@"68" forKeyPath:@"point"];
    
    
    Student *student3 = [[Student alloc]init];
    [student3 setValue:@"98" forKeyPath:@"point"];
    
    Student *student4 = [[Student alloc]init];
    [student4 setValue:@"45" forKeyPath:@"point"];
    
    NSArray *array = [NSArray arrayWithObjects:student1,student2,student3,student4,nil];
    
    //必须加上 这行代码
    [student setValue:array forKey:@"otherStudent"];
    
    NSLog(@"其他学生的成绩%@", [student valueForKeyPath:@"otherStudent.point"]);
    NSLog(@"共%@个学生", [student valueForKeyPath:@"otherStudent.@count"]);
    NSLog(@"最高成绩:%@", [student valueForKeyPath:@"otherStudent.@max.point"]);
    NSLog(@"最低成绩:%@", [student valueForKeyPath:@"otherStudent.@min.point"]);
    NSLog(@"平均成绩:%@", [student valueForKeyPath:@"otherStudent.@avg.point"]);
    NSLog(@"总成绩:%@", [student valueForKeyPath:@"otherStudent.@sum.point"]);

}

- (void)testKVCOfArray {
    //2016-12-01 23:10:10.577 BYMFinancing[22800:6692933] *** Terminating app due to uncaught exception 'NSUnknownKeyException', reason: '[<__NSCFConstantString 0x10035d2f0> valueForUndefinedKey:]: this class is not key value coding-compliant for the key point.'
    
    NSArray *testArray = [NSArray arrayWithObjects:@"1",@"6",@"3",@"4",nil];
    NSLog(@"%@", [testArray valueForKeyPath:@"@count"]);
    NSLog(@"%@", [testArray valueForKeyPath:@"@max.floatValue"]);
    NSLog(@"%@", [testArray valueForKeyPath:@"@min.floatValue"]);
    NSLog(@"%@", [testArray valueForKeyPath:@"@avg.floatValue"]);
    NSLog(@"%@", [testArray valueForKeyPath:@"@sum.floatValue"]);
}

// TODO: kvo someInfo 知识
- (void)testKVO {
    
    //name 也可以
    self.student = [[Student alloc]init];
    [self.student addObserver:self forKeyPath:@"testKVOValue" options:NSKeyValueObservingOptionNew context:nil];
    self.student.testKVOValue = @"1";
    self.student.testKVOValue = @"2";
}

- (void)dealloc
{
    NSLog(@"testKVOValue 属性销毁了");
    [self.student  removeObserver:self forKeyPath:@"testKVOValue" context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context
{
    NSLog(@"keyPath = %@",keyPath);
    NSString *newValue = change[@"new"];
    NSLog(@"newValue = %@",newValue);
}



@end
