//
//  JuRefreshBase.h
//  JuRefresh
//
//  Created by Juvid on 16/9/7.
//  Copyright © 2016年 Juvid(zhutianwei). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JuRefresh.h"
@interface JuRefreshBase : UIView{
   __weak UIScrollView *scrollView;
    BOOL isFirstConfig;
    CGFloat ju_InsetTop;///< 原始上边距
    CGFloat ju_InsetBottom;///< 原始下边距
    CGFloat ju_RefreshOffsetH;///< 拖动时临界点高度
}

@property(strong, nonatomic) UIActivityIndicatorView *loadingAni;
@property(strong, nonatomic) UILabel *labTitle;

- (void)juSetView;

@end
