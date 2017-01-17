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
//+(instancetype)juHeadWithhandle:(dispatch_block_t)handle;
//+(instancetype)juFootWithhandle:(shLoadNextPage)handle;
//+(instancetype)juFoot;

//@property (nonatomic,copy  ) dispatch_block_t ju_StartRefresh;//开始刷新
//@property (nonatomic,copy  ) shLoadNextPage ju_LoadMore;//开始刷新
@property(strong, nonatomic) UIActivityIndicatorView *loadingAni;
@property(strong, nonatomic) UILabel *labTitle;

- (void)juSetView;

@end
