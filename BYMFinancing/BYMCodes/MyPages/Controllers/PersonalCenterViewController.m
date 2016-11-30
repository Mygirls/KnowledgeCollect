//
//  PersonalCenterViewController.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "ChangeLogInPasswordViewController.h"
#import "ForgetTradePasswordViewController.h"
#import "PTImageCropViewController.h"

@interface PersonalCenterViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate, UIActionSheetDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *nameArray;
@property(nonatomic,strong)NSArray *nameArray2;
@property(nonatomic,strong)NSArray *nameArray3;
@property(nonatomic,strong)NSArray *nameArray4;
@property(nonatomic,strong)UISwitch *switchView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *userImageView;

@end

@implementation PersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.lineHad = YES;
    [self _initViewBackItem];
    
   
    [self.view addSubview:self.titleLabel];
    [self _initMyAccountSubViews]; /** 初始化视图 */
   

}

-(void)_initViewBackItem
{
    
    UIButton *backItem = [UIButton buttonWithType:UIButtonTypeCustom];
    backItem.frame = CGRectMake(0, 0, 10, 19);
    [backItem setBackgroundImage:[UIImage imageNamed:@"sm_back"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(backItemAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    self.navigationItem.leftBarButtonItem = menuButton;
    
    UIButton *rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    rightItem.frame = CGRectMake(0, 0, 70, 20);
    [rightItem setTitle:@"安全退出" forState:UIControlStateNormal];
    rightItem.titleLabel.font = BYM_LabelFont(15);
    [rightItem setTitleColor:HMColor(247, 69, 69) forState:UIControlStateNormal];
    [rightItem addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
    self.navigationItem.rightBarButtonItem = rightButton;
    
}
- (void)rightButtonClick
{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDefulats"];
    if (str != nil) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"你确定退出登录？" message:@"" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"确定", nil];
        alert.delegate = self;
        alert.tag=1000;
        [alert show];
    }
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, KScreen_Width, 18)];
        _titleLabel.text  = @"个人中心";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font  =BYM_LabelFont(18);
        _titleLabel.textColor = HMColor(51, 51, 51);
    }
    return  _titleLabel;
}

- (UIImageView *)userImageView {
    if (!_userImageView) {
        CGFloat w = 41.0f; CGFloat h = w;
        _userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 17, w, h)];
        [_userImageView.layer setCornerRadius:(_userImageView.frame.size.height/2)];
        [_userImageView.layer setMasksToBounds:YES];
        [_userImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_userImageView setClipsToBounds:YES];
    }
    return _userImageView;
}

- (void)_initMyAccountSubViews
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    app_Version = [NSString stringWithFormat:@"v%@",app_Version];
    
    if ([self.dataList objectForKey:@"list"] == nil) {      /**  未认证  */
        _nameArray2 = @[@[@""],@[@"未认证",@"未绑定"],@[@"",@""],@[@"",@"",@""],@[@"",@"",app_Version]];
        
    } else {
        NSDictionary *list = [[self.dataList objectForKey:@"list"] firstObject];
        NSString *bankAccount = [NSString stringWithFormat:@"%@", [list objectForKey:@"bankAccount"] ];
        NSString *idcard = [NSString stringWithFormat:@"%@", [list objectForKey:@"idcard"] ];
        NSInteger index = bankAccount.length - 1;
        NSString *s = [bankAccount substringFromIndex:(index - 9)];
        _nameArray2 = @[@[@""],@[idcard,s],@[@"",@""],@[@"",@"",@""],@[@"",@"",app_Version]];
    }
    _nameArray = @[@[@""],@[@"实名认证",@"我的银行卡"],@[@"修改登录密码",@"修改交易密码"],@[@"指纹密码锁定",@"手势密码锁定",@"修改/忘记手势密码锁定"],@[@"联系我们",@"意见反馈",@"版本信息"]];
    _nameArray4 = @[@[@""],@[@"tx_xy",@"tx_xy"],@[@"tx_xy",@"tx_xy"],@[@"",@"",@"tx_xy"],@[@"tx_xy",@"tx_xy",@""]];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height -64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:244/255.0 blue:245/255.0 alpha:1];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section != 0){
        UIView *headerView = [[UIView alloc] init];
        headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 8);
        headerView.backgroundColor = HMColor(240, 244, 245);
        return headerView;
    }else{
        return nil;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return 2;
    }else if(section == 2){
        return 2;
    }else if(section == 3){
        NSString *switchViewState = [BYM_UserDefulats objectForKey:@"switchViewState"];
        if ([switchViewState isEqualToString:@"1"]) {
            return 3;
        }else{
            return 2;
        }
    }else{
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else{
        return 8;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return  76;
    } else {
        return 45;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"myAccountCellId";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    /** 右边箭头 */
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 20, (cell.height - 13)/2.0, 8, 13)];
    imgView1.image = [UIImage imageNamed:_nameArray4[indexPath.section][indexPath.row]];
    [cell.contentView addSubview:imgView1];
    /** 左边标题 */
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 45)];
    titleLabel.font = BYM_LabelFont(15);
    titleLabel.textColor =  [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    titleLabel.text = _nameArray[indexPath.section][indexPath.row];
    [cell.contentView addSubview:titleLabel];
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 130, 0, 100, 45)];                                                        /** 右边标题 */
    rightLabel.textColor = HMColor(165, 165, 165);
    rightLabel.font = BYM_LabelFont(12);
    rightLabel.textAlignment = NSTextAlignmentRight;
    rightLabel.text = _nameArray2[indexPath.section][indexPath.row];
    [cell.contentView addSubview:rightLabel];
    
    if (indexPath.row == 1) {                                               /** 浅颜色分割线 */
        UIView *label1 = [[UIView alloc]initWithFrame:CGRectMake(10, 0, KScreen_Width-20, 0.5)];
        label1.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];
        [cell.contentView addSubview:label1];
    }
    if ((indexPath.section == 4 && indexPath.row ==2)||(indexPath.section==3 && indexPath.row == 2)) {
        UIView *label1 = [[UIView alloc]initWithFrame:CGRectMake(10, 0, KScreen_Width-20, 0.5)];
        label1.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];
        [cell.contentView addSubview:label1];
    }
    
    if (indexPath.section == 0) {
        
        UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 17, 95, 45)]; /** 用户帐号  */
        userLabel.font  = BYM_LabelFont(15);
        userLabel.textColor = HMColor(51, 51, 51);
        
        UIImageView *levelImg = [[UIImageView alloc] initWithFrame:CGRectMake(userLabel.x+userLabel.width, 32, 15, 15)];
        
        UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(KScreen_Width - 20, (76 - 13)/2.0, 8, 13)];
        imgView1.image = [UIImage imageNamed:@"tx_xy"];     /** 右边箭头 */
        [cell.contentView addSubview:imgView1];
        
        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(KScreen_Width - 130, 0, 100, 76)];
        rightLabel.text = @"修改头像";
        rightLabel.textColor = HMColor(165, 165, 165);      /** 右边标题 */
        rightLabel.font = BYM_LabelFont(12);
        rightLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:rightLabel];
        
        [cell.contentView addSubview:self.userImageView];
        [cell.contentView addSubview:userLabel];
        [cell.contentView addSubview:levelImg];
        
        [self.userImageView  sd_setImageWithURL:[NSURL URLWithString:[[self.dataList objectForKey:@"obj"] objectForKey:@"userPhotos"]] placeholderImage:[UIImage imageNamed:@"basemap"]];
        userLabel.text = [NSString stringWithFormat:@"%@",self.userNum];
        [self showLevelImage:levelImg];
    }
    
    if (indexPath.section == 3) {
        if (indexPath.row == 0 ) {                          /** 指纹  */
            _switchView = [[UISwitch alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 60, 7, 51, 30)];
            NSString *switchActionOpenTouchIdState = [BYM_UserDefulats objectForKey:@"switchActionOpenTouchIdState"];
            [BYM_UserDefulats synchronize];
            _switchView.on = [switchActionOpenTouchIdState integerValue];
            [_switchView addTarget:self action:@selector(switchActionOpenTouchId:) forControlEvents:UIControlEventValueChanged];
            [cell.contentView addSubview:_switchView];
        }else if (indexPath.row == 1){                      /** 手势密码 */
            UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 60, 7, 51, 30)];
            NSString *switchViewState = [BYM_UserDefulats objectForKey:@"switchViewState"];
            [BYM_UserDefulats synchronize];
            switchView.on = [switchViewState integerValue];
            [switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            [cell.contentView addSubview:switchView];
        }
    }
    
    if (indexPath.section == 0 &&[self.dataList objectForKey:@"list"] == nil) {
        rightLabel.textColor = HMColor(247, 69, 69);
    }
    
    
    return cell;
    
}

- (void)showLevelImage:(UIImageView *)imgView
{
    if ([[[self.dataList objectForKey:@"obj"] objectForKey:@"level"] isEqualToString:@"0"]) {
        imgView.image = [UIImage imageNamed:@"vip_icon_un"];
    }else  if ([[[self.dataList objectForKey:@"obj"] objectForKey:@"level"] isEqualToString:@"1"]) {
        imgView.image = [UIImage imageNamed:@"vip_icon1"];
    }else if ([[[self.dataList objectForKey:@"obj"] objectForKey:@"level"] isEqualToString:@"2"]) {
        imgView.image = [UIImage imageNamed:@"vip_icon2"];
    }else if ([[[self.dataList objectForKey:@"obj"] objectForKey:@"level"] isEqualToString:@"3"]) {
        imgView.image = [UIImage imageNamed:@"vip_icon3"];
    }else if ([[[self.dataList objectForKey:@"obj"] objectForKey:@"level"] isEqualToString:@"4"]) {
        imgView.image = [UIImage imageNamed:@"vip_icon4"];
    }else if ([[[self.dataList objectForKey:@"obj"] objectForKey:@"level"] isEqualToString:@"5"]) {
        imgView.image = [UIImage imageNamed:@"vip_icon5"];
    }else if ([[[self.dataList objectForKey:@"obj"] objectForKey:@"level"] isEqualToString:@"6"]) {
        imgView.image = [UIImage imageNamed:@"vip_icon6"];
    }else if ([[[self.dataList objectForKey:@"obj"] objectForKey:@"level"] isEqualToString:@"7"]) {
        imgView.image = [UIImage imageNamed:@"vip_icon7"];
    }else {
        
    }
}

/** 指纹解锁密码 */
- (void)switchActionOpenTouchId:(UISwitch *)switchActionOpenTouchId
{
//    NSString *switchViewState =  [BYM_UserDefulats objectForKey:@"switchViewState"];
//    if ([switchViewState isEqualToString:@"1"]) {
//        //        NSLog(@"%d",switchActionOpenTouchId.on);
//        LAContext *context = [[LAContext alloc] init];
//        NSError *error = nil;
//        context.localizedFallbackTitle = @"";
//        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
//            if (switchActionOpenTouchId.on == YES) {
//                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"开启指纹解锁" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//                [alter show];
//            }
//        } else {
//            switchActionOpenTouchId.on = NO;
//            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"对不起,您还未开启指纹解锁" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
//            [alter show];
//        }
//        NSString *switchActionOpenTouchIdState = [NSString stringWithFormat:@"%d",switchActionOpenTouchId.on];
//        [BYM_UserDefulats setObject:switchActionOpenTouchIdState forKey:@"switchActionOpenTouchIdState"];
//        [BYM_UserDefulats synchronize];
//        
//    } else {
//        switchActionOpenTouchId.on = NO;
//        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"请先开启手势解锁" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [alter show];
//    }
}

/** 手势密码开启按钮 */
- (void)switchAction:(UISwitch *)switchView
{
    [switchView setOn:switchView.on animated:YES];
//    NSString *gesturePWD = [BYM_UserDefulats objectForKey:@"password"];
//    if (gesturePWD ==nil && gesturePWD.length == 0) {
//        SettingGesturePWDViewController *setGestureVc = [[SettingGesturePWDViewController alloc] init];
//        setGestureVc.myGestureBlock = ^{
//            NSString *gesturePWD = [BYM_UserDefulats objectForKey:@"password"];
//            if (gesturePWD ==nil && gesturePWD.length == 0) {
//                [BYM_UserDefulats setObject:@"0" forKey:@"switchViewState"];
//                switchView.on = NO;
//            }else{
//                [BYM_UserDefulats setObject:@"1" forKey:@"switchViewState"];
//                switchView.on = YES;
//            }
//            [_tableView reloadData];
//            
//        };
//        [self presentViewController:setGestureVc animated:YES completion:nil];
//    }
    NSString *switchViewState = [NSString stringWithFormat:@"%d",switchView.on];
    [BYM_UserDefulats setObject:switchViewState forKey:@"switchViewState"];
    [BYM_UserDefulats synchronize];
    if (switchView.on == 0) {
        [BYM_UserDefulats setObject:@"0" forKey:@"switchActionOpenTouchIdState"];
        [BYM_UserDefulats synchronize];
        [_switchView setOn:NO animated:YES];
    }
    [_tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){                                    /** 更换头像 */
        UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:@"更换头像"
                                                                 delegate:self
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"拍照", @"从相册中选取", nil];
        [choiceSheet showInView:self.view];
        
    }else if (indexPath.section == 1) {                             /**  实名认证 和 绑定银行卡  */
        if ([self.dataList objectForKey:@"list"] == nil) {
//            [self showHUD:@"充值即可完成实名认证"];
//            [self hideHUD:@"充值即可完成实名认证"];
            [self performSelector:@selector(shimingrenzheng) withObject:nil afterDelay:2.0];
            
        }else{
//            LLAuthenticateViewControllerViewController *llauVc = [[LLAuthenticateViewControllerViewController alloc] init];
//            llauVc.dataList = self.dataList;
//            llauVc.isUnbind = self.isUnbind;
//            [self.navigationController pushViewController:llauVc animated:YES];
        }
        
    } else if (indexPath.section == 2 && indexPath.row == 0){       /** 修改登录密码 */
        ChangeLogInPasswordViewController *changeLPVC = [[ChangeLogInPasswordViewController alloc]init];
        changeLPVC.title = @"修改登录密码";
        [self.navigationController pushViewController:changeLPVC animated:YES];
        
    } else if(indexPath.section == 2 && indexPath.row == 1){        /** 忘记交易密码 */
        ForgetTradePasswordViewController *forgetTPVC = [[ForgetTradePasswordViewController alloc] init];
//        [forgetTPVC countStart:_j];
        forgetTPVC.title = @"修改交易密码";
        [self.navigationController pushViewController:forgetTPVC animated:YES];
        
    }else if(indexPath.section == 3 && indexPath.row == 2){         /** 修改手势密码 */
//        ChangeGesturePasswordVC *changeGesturePasswordVC = [[ChangeGesturePasswordVC alloc]init];
//        [self.navigationController pushViewController:changeGesturePasswordVC animated:YES];
        
    }else if(indexPath.section == 4 && indexPath.row == 0){         /** 联系我们 */
//        ContactUsViewController *contactVc = [[ContactUsViewController alloc] init];
//        [self.navigationController pushViewController:contactVc animated:YES];
        
    }else if (indexPath.section == 4 && indexPath.row == 1){        /** 意见反馈 */
//        DebunkViewController *debunkVc = [[DebunkViewController alloc] init];
//        [self.navigationController pushViewController:debunkVc animated:YES];
    }
}

#pragma mark - UIAlertView delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000) {                              /** 确定退出 */
        if (buttonIndex==1)
        {
            /** 移除本地保存的认证信息 */
            [BYM_UserDefulats removeObjectForKey:@"resultLevel"]; /** 移除vip等级 **/
            [BYM_UserDefulats removeObjectForKey:@"userDefulats"];
            [BYM_UserDefulats removeObjectForKey:@"stayMoney"];
            [BYM_UserDefulats removeObjectForKey:@"autotype"];
            [BYM_UserDefulats removeObjectForKey:@"isSecret"];
            [BYM_UserDefulats removeObjectForKey:@"password"];     /** 移除手势密码 */
            [BYM_UserDefulats removeObjectForKey:@"switchViewState"];
            [BYM_UserDefulats synchronize];
            
//            [self showHUD:@"退出成功"];
//            [self hideHUD:@"退出成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}

- (void)shimingrenzheng
{
//    LLPayViewController *llVc = [[LLPayViewController alloc] init];
//    llVc.leftMoney = self.leftMoney;
//    [self.navigationController pushViewController:llVc animated:YES];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
        {
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController* picker = [[UIImagePickerController alloc] init];
                picker.delegate = self;                       /**  拍照  */
                picker.sourceType = sourceType;
                [self presentViewController:picker animated:YES completion:nil];
            }
            break;
        }
        case 1:
        {
            UIImagePickerController* picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;                           /**  进入相册  */
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:nil];
            break;
        }
        default:
            break;
    }
    
}

- (NSString *)encodeToBase64String:(UIImage *)image{           /**  选取照片 */
    NSString * test = [UIImageJPEGRepresentation(image, 0.1f) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return test;
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *infoImage = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:NO completion:nil];
    
    PTImageCropViewController* cropVC = [[PTImageCropViewController alloc] initWithImage:infoImage withCropScale:0 complentBlock:^(UIImage* image) {
        
        [self upLoadImagView:image];                        /**  上传服务器 */
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } cancelBlock:^(id sender) {
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    [self presentViewController:cropVC animated:YES completion:nil];
}

/**    将选取图片上传服务器  */
-(void)upLoadImagView:(UIImage *)image{
    
    NSString *image64 = [self encodeToBase64String:image];
    /** 去除掉首尾的空白字符和换行字符  */
    image64 = [image64 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    image64 = [image64 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    image64 = [image64 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    /**  将选取相片上传到服务器  */
    NSDictionary *result = [BYM_UserDefulats objectForKey:@"userDefulats"];
    NSDictionary *subDic = [result objectForKey:@"obj"];
    NSString *authorization = [subDic objectForKey:@"authorization"];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    NSString *str = [NSString stringWithFormat:  @"{\"authorization\":\"%@\",\"imgByte\":\"%@\"}",authorization,image64];
    [dic setObject:str forKey:@"parameters"];
    [BYMBaseRequest requestWithURL:@"User/uploadImg" params:dic httpMethod:@"POST" blockSuccess:^(id result) {
        
            if ([result isKindOfClass:[NSError class]]) {
//                [self showHUD:@"网络或服务器异常"];
//                [self hideHUD:@"网络或服务器异常"];
            } else if ([[result objectForKey:@"end"] isEqualToString:@"ok"]) {
                [self.userImageView  sd_setImageWithURL:[NSURL URLWithString:[result objectForKey:@"path"]] placeholderImage:[UIImage imageNamed:@""]];
            } else if ([[result objectForKey:@"end"] isEqualToString:@"noLogin"]) {
                
            } else {
                
            }
    } blockFailure:^(id result) {
        
    }];
}
- (void)backItemAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] delegate].window.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
}

@end
