//
//  SelectLineWidthView.h
//  画板课堂
//
//  Created by GG on 16/5/11.
//  Copyright © 2016年 GG. All rights reserved.
//

#import "BaseView.h"

typedef void(^SelectLineWidthBlock)(CGFloat lineWidth);

@interface SelectLineWidthView : BaseView

- (void)afterSelect:(SelectLineWidthBlock)selectLineWidthBlock;


@end
