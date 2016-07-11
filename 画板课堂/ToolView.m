//
//  ToolView.m
//  画板课堂
//
//  Created by GG on 16/5/11.
//  Copyright © 2016年 GG. All rights reserved.
//

#import "ToolView.h"
#import "SelectColorView.h"
#import "SelectLineWidthView.h"
typedef enum : NSUInteger {
    kColorSelect = 100,
    kLineWidthSelect,
    KEraserSelect,
    kUndoSelect,
    kClearScreenSelect,
    kcameraSelect,
    kSaveSelect
} kSelectItem;

@interface ToolView ()
{
    SelectLineWidthBlock _selectLineWidthBlock;
    
    SelectColorBlock _selectColorBlock;
    
    ToolActionBlock _araserBlock;
    ToolActionBlock _undoBlock;
    ToolActionBlock _clearBlock;
    ToolActionBlock _saveBlock;
    
}
//颜色选择视图
@property (nonatomic,strong) SelectColorView *selectColorView;

//线宽选择视图
@property (nonatomic,strong) SelectLineWidthView *selectLineWidthView;

@end


@implementation ToolView

- (void)selectChangeItem:(UIButton *)sender{
    
    switch (sender.tag) {
            
        case kColorSelect:{
            
            [self forceHideView:self.selectColorView];
            
            [self showHideColorSelectView];
            
        }break;
            
        case kLineWidthSelect:{
            
            [self forceHideView:self.selectLineWidthView];
            
            [self showHideLineWidthSelectView];
            
        }break;
            
        case KEraserSelect:{
            
            _araserBlock();
            
        }break;
            
        case kUndoSelect:{
            
            _undoBlock();
            
        }break;
            
        case kClearScreenSelect:{
            
            _clearBlock();
            
        }break;
            
        case kSaveSelect:{
            
            _saveBlock();
            
        }break;
            
            
            
    }
}

//让线宽选择视图显示或隐藏
- (void)showHideLineWidthSelectView{
    
    NSArray *contextArray = @[@"1",@"3",@"5",@"7",@"10",@"14"];
    
    if (self.selectLineWidthView == nil) {
        
        self.selectLineWidthView = [[SelectLineWidthView alloc]initWithFrame:CGRectMake(0, -50, 414, 50) WithArray:contextArray];
        
        [self.selectLineWidthView afterSelect:^(CGFloat lineWidth) {
           
            _selectLineWidthBlock(lineWidth);
            
            [self forceHideView:nil];
            
        }];
        
        
        [self addSubview:self.selectLineWidthView];
    }
    
    [self showHideView:self.selectLineWidthView];
    
}

//让颜色选择视图显示或隐藏
- (void)showHideColorSelectView{
    
    NSArray *contentArray = @[[UIColor redColor],[UIColor grayColor],[UIColor orangeColor],[UIColor whiteColor],[UIColor blueColor],[UIColor purpleColor],[UIColor cyanColor]];
    
    if (self.selectColorView == nil) {
        
        self.selectColorView = [[SelectColorView alloc]initWithFrame:CGRectMake(0, -50, 414, 50) WithArray:contentArray];
        
        [self.selectColorView afterSelected:^(UIColor *color) {
           
            _selectColorBlock(color);
            
            [self forceHideView:nil];
            
        }];
        
        self.selectColorView.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:self.selectColorView];
    }
    
    [self showHideView:self.selectColorView];
    
}

//让视图动画式出现及消失
- (void)showHideView:(UIView *)view{
    
    //保存要消失或出现视图的frame
    CGRect toFrame = view.frame;
    //保存当前工具栏的frame
    CGRect toolFrame = self.frame;
    
    if (toFrame.origin.y>0) {
        
        toFrame.origin.y = -50;
        toolFrame.size.height = 50;
    }else{
        
        toFrame.origin.y = 50;
        
        toolFrame.size.height = 100;
    }
    
    //colorView : 0 50 414 50
    //toolView :  0 0   414 100
    
    [UIView animateWithDuration:0.5 animations:^{
       
        view.frame = toFrame;
        self.frame = toolFrame;
        
    }];
    
}

//强制隐藏视图
- (void)forceHideView:(UIView *)view{
    
    UIView *showView = nil;
    if (self.selectColorView.frame.origin.y>0) {
        
        showView = self.selectColorView;
        
    }else if(self.selectLineWidthView.frame.origin.y>0){
        
        showView = self.selectLineWidthView;
    }else{
     
        return;
    }
    
    if (view == showView) {
        
        return;
    }
    
    CGRect toFrame = showView.frame;
    CGRect toolFrame = self.frame;
    
    
    toFrame.origin.y = -50;
    toolFrame.size.height = 50;
    
    [UIView animateWithDuration:0.5 animations:^{
       
        showView.frame = toFrame;
        
        self.frame = toolFrame;
    }];
}


- (void)afterSelectColor:(SelectColorBlock)selectColorBlock afterSelectLineWidth:(SelectLineWidthBlock)selectLineWidth{
    
    _selectLineWidthBlock = selectLineWidth;
    _selectColorBlock = selectColorBlock;
    
    
}

- (void)clickEraserBlock:(ToolActionBlock)araserBlock WithUndoBlock:(ToolActionBlock)undoBlock WithClearBlock:(ToolActionBlock)clearBlock WithSaveBlock:(ToolActionBlock)saveBlock{
    
    _araserBlock = araserBlock;
    _undoBlock = undoBlock;
    _clearBlock = clearBlock;
    _saveBlock = saveBlock;
    
}

@end
