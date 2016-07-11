//
//  SelectLineWidthView.m
//  画板课堂
//
//  Created by GG on 16/5/11.
//  Copyright © 2016年 GG. All rights reserved.
//

#import "SelectLineWidthView.h"

@interface SelectLineWidthView ()
{
    
    SelectLineWidthBlock _selectLineWidthBlock;
}

@end

@implementation SelectLineWidthView

- (void)afterSelect:(SelectLineWidthBlock)selectLineWidthBlock{
    
    _selectLineWidthBlock = selectLineWidthBlock;
    
    
}

- (void)selectChangeItem:(UIButton *)sender{
    
    float lineWidth = [self.contentArray[sender.tag-100] floatValue];
    
    
    _selectLineWidthBlock(lineWidth);
    
}

@end
