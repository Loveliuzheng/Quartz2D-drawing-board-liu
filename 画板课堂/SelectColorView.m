//
//  SelectColorView.m
//  画板课堂
//
//  Created by GG on 16/5/11.
//  Copyright © 2016年 GG. All rights reserved.
//

#import "SelectColorView.h"

@interface SelectColorView ()
{
    SelectColorBlock _selectColorBlock;
}

@end

@implementation SelectColorView

- (void)afterSelected:(SelectColorBlock)selectBlock{
    
    _selectColorBlock = selectBlock;
    
    
}


- (void)selectChangeItem:(UIButton *)sender{
    
    _selectColorBlock(self.contentArray[sender.tag-100]);
    
}

@end
