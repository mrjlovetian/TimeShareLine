//
//  USWebViewController.h
//  TimeShareLine
//
//  Created by MRJ on 2019/5/22.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GKPageScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@interface USWebViewController : UIViewController<GKPageListViewDelegate>

@property (nonatomic, strong)NSString *webUrlStr;

@end

NS_ASSUME_NONNULL_END
