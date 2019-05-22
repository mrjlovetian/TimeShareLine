//
//  USWebViewController.m
//  TimeShareLine
//
//  Created by MRJ on 2019/5/22.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "USWebViewController.h"
#import <WebKit/WebKit.h>

@interface USWebViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong)WKWebView *webView;
@property (nonatomic, copy) void(^listScrollViewScrollCallback)(UIScrollView *scrollView);

@end

@implementation USWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[WKWebView alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.webView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - kBaseSegmentHeight - 64);

    self.webView.scrollView.delegate = self;
//    }
    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self loadWebView];
    [self.view addSubview:self.webView];
    // Do any additional setup after loading the view.
}

- (void)loadWebView {
    NSString *urlStr = [self.webUrlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [[NSURL alloc] initWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0];
    [self.webView loadRequest:request];
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    !self.listScrollViewScrollCallback ? : self.listScrollViewScrollCallback(scrollView);
}

#pragma mark - GKPageListViewDelegate
- (UIView *)listView {
    return self.view;
}

- (UIScrollView *)listScrollView {
    return self.webView.scrollView;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.listScrollViewScrollCallback = callback;
}

- (UIImage *)changeImageWithImage:(UIImage *)image color:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, image.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextClipToMask(context, rect, image.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
