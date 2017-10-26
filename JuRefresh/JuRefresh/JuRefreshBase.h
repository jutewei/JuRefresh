//
//  JuRefreshBase.h
//  JuRefresh
//
//  Created by Juvid on 16/9/7.
//  Copyright © 2016年 Juvid(zhutianwei). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JuRefresh.h"
typedef void(^shLoadNextPage)(BOOL isNextPage);//下步操作后有跟新数据
@interface JuRefreshBase : UIView{
    __weak UIScrollView *scrollView;
    //    UIEdgeInsets scrollContentInset;
    BOOL isFirstConfig;
    CGFloat ju_InsetTop;///< 原始上边距
    CGFloat ju_InsetBottom;///< 原始下边距
    CGFloat ju_RefreshOffsetH;///< 拖动时临界点高度
}

@property(readonly, nonatomic) UIActivityIndicatorView *loadingAni;
@property(readonly, nonatomic) UILabel *labTitle;

- (void)juSetView;

@end

