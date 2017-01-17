//
//  HBActionSheet.m
//  hotbody
//
//  Created by xinfeng on 16/5/17.
//  Copyright © 2016年 Beijing Fitcare inc. All rights reserved.
//

#import "XFActionSheet.h"

// main screen's width (portrait)
#ifndef kScreenWidth
#define kScreenWidth [UIApplication sharedApplication].keyWindow.frame.size.width
#endif

// main screen's height (portrait)
#ifndef kScreenHeight
#define kScreenHeight [UIApplication sharedApplication].keyWindow.frame.size.height
#endif

#define HBColorA(r, g, b ,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define HBColor(r, g, b) HBColorA(r, g, b ,1.0f)
#define TITLE_TEXT_COLOR                    HBColor(77, 77, 77)     //标题
#define DESCRIPTIVE_TEXT_COLOR              HBColor(128, 128, 128)  //描述文字
#define CANCELANDOTHER_BUTTON_TITLE_COLOE   HBColor(0, 118, 255)    //蓝色
#define DESCRIPTIVE_BUTTON_TITLE_COLOR      HBColor(254, 56, 36)    //红色

#define CANCELANDOTHER_BUTTON_TITLE_FONT    [UIFont boldSystemFontOfSize:17.f]
#define NORMAL_BUTTON_TITLE_FONT            [UIFont systemFontOfSize:17.f]


#define SELECTED_BUTTON_COLOR               HBColor(204, 204, 204)  //button选中颜色

static const CGFloat kButton_Height = 60.0f;
static const CGFloat kControl_InterVal = 14.0f;
static const CGFloat kText_Margin = 60.0f;

typedef void(^touchItemBlock)(XFActionSheet *, NSString *, NSInteger );

@interface XFActionSheet ()

@property (nonatomic, weak) UIView *bgBlackView; //背景透明视图
@property (nonatomic, weak) UIView *btnBgView;  //按钮背景视图
@property (nonatomic, weak) UIView *titleView;  //标题视图
@property (nonatomic, weak) UIToolbar *otherButtonBgView; //其他按钮背景视图
@property (nonatomic, weak) UIToolbar *cancelButtonView; //其他按钮背景视图

@property (nonatomic, strong) NSMutableArray *classArray;   //按钮集合

@property (nonatomic, assign) CGFloat otherHeight;

@property (nonatomic, copy) touchItemBlock touchItemBlock;

@end

@implementation XFActionSheet

#pragma mark - Public method
- (void)showAction{
    [_btnBgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-kControl_InterVal));
    }];
    
    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.bgBlackView.alpha = 0.4f;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismissAction{
    [_btnBgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(_otherHeight));
    }];
    [UIView animateWithDuration: 0.25 animations:^{
        self.bgBlackView.alpha = 0.0f;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)dismissActionWhenTapBackgroundView{
    [_btnBgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(_otherHeight));
    }];
    [UIView animateWithDuration: 0.25 animations:^{
        self.bgBlackView.alpha = 0.0f;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (_classArray.count>0 && _touchItemBlock) {
            UIButton *cancelButton = _classArray[0];
            _touchItemBlock(self, cancelButton.titleLabel.text, 0);
        }
    }];
}

#pragma mark - Override

#pragma mark - Intial Methods
- (instancetype)initActionSheetWithTitle:(NSString *)title
                         descriptiveText:(NSString *)descriptive
                       cancelButtonTitle:(NSString *)cancelButtonTitle
                  destructiveButtonTitles:(NSArray *)destructiveButtonTitles
                       otherButtonTitles:(NSArray *)otherButtonTitles
                              itemAction:(void(^)(XFActionSheet *actionSheet, NSString *title, NSInteger index))itemAction;
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    self = [super initWithFrame:window.bounds];
    if (self) {
        [window addSubview: self];
        
        _otherHeight    = 0;
        _classArray     = [[NSMutableArray alloc]initWithCapacity:1];
        
        [self bgBlackView];
        [self btnBgView];
        
        [self createBtnBgViewWithTitle:title
                       descriptiveText:descriptive
                     cancelButtonTitle:cancelButtonTitle
                destructiveButtonTitles:destructiveButtonTitles
                     otherButtonTitles:otherButtonTitles];
        
        _touchItemBlock = ^(XFActionSheet *action, NSString *title, NSInteger index){
            itemAction(action, title ,index);
        };
        
        [self layoutIfNeeded];
    }
    return self;
}
#pragma mark - Target Methods

#pragma mark - Delegate Name

#pragma mark - Setter Getter Methods

- (UIView *)bgBlackView{
    if (!_bgBlackView) {
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        UIView *bgBlackView = [[UIView alloc]initWithFrame:window.bounds];
        bgBlackView.backgroundColor = [UIColor blackColor];
        bgBlackView.alpha = 0.0f;
        [self addSubview:bgBlackView];
        // 添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        tap.numberOfTapsRequired = 1;
        [tap addTarget: self action: @selector(dismissActionWhenTapBackgroundView)];
        [bgBlackView addGestureRecognizer: tap];
        _bgBlackView = bgBlackView;
    }
    return _bgBlackView;
}

- (UIView *)btnBgView{
    if (!_btnBgView) {
        UIView *btnBgView = [[UIView alloc]init];
        [self addSubview:btnBgView];
        _btnBgView = btnBgView;
    }
    return _btnBgView;
}

- (UIView *)titleView{
    if (!_titleView) {
        UIView *view = [[UIView alloc]init];
        [_otherButtonBgView addSubview:view];
        _titleView = view;
    }
    return _titleView;
}

- (UIToolbar *)otherButtonBgView{
    if (!_otherButtonBgView) {
        UIToolbar *tempOtherButtonBgView = [[UIToolbar alloc]init];
        tempOtherButtonBgView.layer.cornerRadius = 10;
        tempOtherButtonBgView.layer.masksToBounds = YES;
        [_btnBgView addSubview:tempOtherButtonBgView];
        _otherButtonBgView = tempOtherButtonBgView;
    }
    return _otherButtonBgView;
}

- (UIToolbar *)cancelButtonView {
    if (!_cancelButtonView) {
        UIToolbar *cancelButtonView = [[UIToolbar alloc]init];
        cancelButtonView.layer.cornerRadius = 10;
        cancelButtonView.layer.masksToBounds = YES;
        [_btnBgView addSubview:cancelButtonView];
        _cancelButtonView = cancelButtonView;
        
        [cancelButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_otherButtonBgView.mas_bottom).offset(10);
            make.left.right.bottom.equalTo(@0);
            make.height.equalTo(@(kButton_Height));
        }];
    }
    return _cancelButtonView;
    
}

#pragma mark - Private method
- (void)createBtnBgViewWithTitle:(NSString *)title
                 descriptiveText:(NSString *)descriptive
               cancelButtonTitle:(NSString *)cancelButtonTitle
          destructiveButtonTitles:(NSArray *)destructiveButtonTitles
               otherButtonTitles:(NSArray *)otherButtonTitles{
    
    [self otherButtonBgView];
    [self cancelButtonView];
    
    CGFloat titleBtnBottomY = 0;
    if (title) {
        titleBtnBottomY += [self createTitleLabelWithTitle:title];
    }
    
    if (descriptive) {
        titleBtnBottomY += [self createDescriptiveLabelWithDescriptive:descriptive
                                                       titleBtnBottomY:titleBtnBottomY];
    }
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.height.equalTo(@(titleBtnBottomY));
    }];
    
    CGFloat otherBtnBottomY = titleBtnBottomY;
    CGFloat destructiveBtnBottomY = titleBtnBottomY;
    
    if (otherButtonTitles) {
        destructiveBtnBottomY = [self createOtherButtonWithOtherButtonTitles:otherButtonTitles
                                                             otherBtnBottomY:otherBtnBottomY];
    }
    
    if (destructiveButtonTitles) {
        destructiveBtnBottomY = [self createDestructiveButtonWithDestructiveButtonTitles:destructiveButtonTitles destructiveBtnBottomY:destructiveBtnBottomY];
    }
    
    [_otherButtonBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.height.equalTo(@(destructiveBtnBottomY));
    }];
    
    if (cancelButtonTitle) {
        [self createCancelButtonWithCancelButtonTitle:cancelButtonTitle];
        
        _otherHeight = destructiveBtnBottomY + kControl_InterVal + kButton_Height;
    }else{
        [_otherButtonBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@(-8));
        }];
        _otherHeight = destructiveBtnBottomY + kControl_InterVal;
    }
    [_btnBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kControl_InterVal));
        make.right.equalTo(@(-kControl_InterVal));
        make.bottom.equalTo(self.mas_bottom).offset(_otherHeight);
    }];
}

- (CGFloat)createTitleLabelWithTitle:(NSString *)title {
    UILabel *titleLbl = [[UILabel alloc]init];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.text = [NSString stringWithFormat:@"%@",title];
    titleLbl.textColor = TITLE_TEXT_COLOR;
    titleLbl.font = [UIFont systemFontOfSize:15];
    titleLbl.numberOfLines = 0;
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    CGRect rect = [titleLbl.text boundingRectWithSize:CGSizeMake(kScreenWidth - (2 * kText_Margin + 2 * kControl_InterVal), kScreenHeight)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:attribute
                                              context:nil];
    [self.titleView addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.height.equalTo(@(rect.size.height));
    }];
    return rect.size.height;
}

- (CGFloat)createDescriptiveLabelWithDescriptive:(NSString *)descriptive titleBtnBottomY:(CGFloat)titleBtnBottomY {
    UILabel *descriptiveLbl = [[UILabel alloc]init];
    descriptiveLbl.text = descriptive;
    descriptiveLbl.textColor = DESCRIPTIVE_TEXT_COLOR;
    descriptiveLbl.font = [UIFont systemFontOfSize:15.0];
    descriptiveLbl.textAlignment = NSTextAlignmentCenter;
    descriptiveLbl.numberOfLines = 0;
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15.0]};
    CGRect rect = [descriptiveLbl.text boundingRectWithSize:CGSizeMake(kScreenWidth - (2 * kText_Margin + 2 * kControl_InterVal), kScreenHeight)
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:attribute
                                                    context:nil];
    [self.titleView addSubview:descriptiveLbl];
    CGFloat labelHeight = rect.size.height;
    [descriptiveLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kText_Margin));
        make.right.equalTo(@(-kText_Margin));
        make.top.equalTo(@(titleBtnBottomY + kControl_InterVal));
    }];
    return labelHeight + kControl_InterVal * 2;
}

- (CGFloat)createOtherButtonWithOtherButtonTitles:(NSArray *)otherButtonTitles otherBtnBottomY:(CGFloat)otherBtnBottomY {
    NSInteger count = otherButtonTitles.count;
    for (int i = 0; i < count; i ++) {
        UIButton *other = [self createTitleButtonWithTitle:otherButtonTitles[i]
                                                titleColor:CANCELANDOTHER_BUTTON_TITLE_COLOE];
        other.titleLabel.font = NORMAL_BUTTON_TITLE_FONT;
        [_otherButtonBgView addSubview:other];
        [_classArray addObject:other];
        [other mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(@(otherBtnBottomY));
            make.height.equalTo(@(kButton_Height));
        }];
        otherBtnBottomY += kButton_Height;
    }
    return otherBtnBottomY;
}

- (CGFloat)createDestructiveButtonWithDestructiveButtonTitles:(NSArray *)destructiveButtonTitles destructiveBtnBottomY:(CGFloat)destructiveBtnBottomY {
    NSInteger count = destructiveButtonTitles.count;
    for (int i = 0; i < count; i ++) {
        UIButton *destructive = [self createTitleButtonWithTitle:destructiveButtonTitles[i]
                                                      titleColor:DESCRIPTIVE_BUTTON_TITLE_COLOR];
        destructive.titleLabel.font = NORMAL_BUTTON_TITLE_FONT;
        [_otherButtonBgView addSubview:destructive];
        [_classArray addObject:destructive];
        [destructive mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(@(destructiveBtnBottomY));
            make.height.equalTo(@(kButton_Height));
        }];
        destructiveBtnBottomY += kButton_Height;
    }
    return destructiveBtnBottomY;
}

- (void)createCancelButtonWithCancelButtonTitle:(NSString *)cancelButtonTitle {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = CANCELANDOTHER_BUTTON_TITLE_FONT;
    [button setTitle:cancelButtonTitle forState:UIControlStateNormal];
    button.userInteractionEnabled = NO;
    button.layer.cornerRadius = 10;
    button.layer.masksToBounds = YES;
    [button setTitleColor:CANCELANDOTHER_BUTTON_TITLE_COLOE forState:UIControlStateNormal];
    [_cancelButtonView addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(@0);
    }];
    [_classArray insertObject:button atIndex:0];
}

- (UIButton *)createTitleButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.userInteractionEnabled = NO;
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = SELECTED_BUTTON_COLOR;;
    [button addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.height.equalTo(@(0.5));
    }];
    
    return button;
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    CGPoint point = [touch locationInView:self];
    for (UIButton *button in _classArray) {
        CGRect rect2 = [button convertRect:button.bounds toView:self];
        BOOL contains = CGRectContainsPoint(rect2, point);
        if (contains) {
            button.backgroundColor = SELECTED_BUTTON_COLOR;
            break;
        }else{
            button.backgroundColor = [UIColor clearColor];
        }
    }
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    UITouch *touch=[touches anyObject];
    CGPoint point = [touch locationInView:self];
    NSInteger touchItemIndex = 0;
    NSInteger count = _classArray.count;
    for (int i = 0; i < count; i ++) {
        UIButton *button = _classArray[i];
        CGRect rect2 = [button convertRect:button.bounds toView:self];
        BOOL contains = CGRectContainsPoint(rect2, point);
        if (contains) {
            button.backgroundColor = [UIColor clearColor];
            touchItemIndex = i;
            _touchItemBlock(self, button.titleLabel.text, touchItemIndex);
//            if (i == 0) {
//                [self dismissAction];
//            }
            break;
        }
    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    CGPoint point = [touch locationInView:self];
    for (UIButton *button in _classArray) {
        CGRect rect2 = [button convertRect:button.bounds toView:self];
        BOOL contains = CGRectContainsPoint(rect2, point);
        if (contains) {
            button.backgroundColor = SELECTED_BUTTON_COLOR;
        }else{
            button.backgroundColor = [UIColor clearColor];
        }
    }
}

@end






