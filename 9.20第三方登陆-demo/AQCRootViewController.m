//
//  AQCRootViewController.m
//  第三方登陆demo-umeng
//
//  Created by  apple｀ on 16/9/20.
//  Copyright © 2016年  apple｀. All rights reserved.
//

#import "AQCRootViewController.h"
#import "UMSocial.h"

@interface AQCRootViewController ()<UMSocialUIDelegate>

@end

@implementation AQCRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 self.view.backgroundColor = [UIColor whiteColor];
    UIButton * shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(100, 100, 150, 40);
    [shareButton setTitle:@"分享到新浪按钮" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareButton];
   }
-(void)shareButtonClick{
    NSLog(@"你点击了分享");
    NSArray *snsNames = [NSArray arrayWithObjects:UMShareToWechatTimeline,UMShareToWechatSession,UMShareToQzone,UMShareToQQ,UMShareToTencent,UMShareToSina,UMShareToWechatTimeline,UMShareToSms,UMShareToDouban,UMShareToRenren,UMShareToQQ,UMShareToFacebook,UMShareToEmail, nil];
    //参数
    NSString *shareText = @"umengShareTest";
    UIImage *shareImage = [UIImage imageNamed:@"123"];
    // 设置统一标题
    [UMSocialData defaultData].extConfig.title = @"umengTestTitle";
    //分平台设置标题,朋友圈只显示标题
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"朋友圈Title";
    
    //url 当前仅发现必须分平台设置，appDelegate里已设置过，但此处优先级更高
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"www.baidu.com";
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"57e0ba3be0f55a43f500199d" shareText:shareText shareImage:shareImage shareToSnsNames:snsNames delegate:self];
}
//判断分享平台，定制分享内容
- (void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData
{
    if ([platformName isEqualToString:UMShareToSms]) {
        socialData.shareImage = nil;
    } else if ([platformName isEqualToString:UMShareToSina]) {
        //微博分享没有标题，url跳转事件
        socialData.shareText = @"umeng第三方分享测试->新浪微博分享内容,url => www.baidu.com";
    }
}
//分享回调方法
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
     NSLog(@"*****%d", response.responseCode);
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

@end
