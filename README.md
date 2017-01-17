# XFActionSheet

模仿系统UIActionSheet，支持修改标题，描述，按钮颜色，内容，高度等属性。

用到的第三方：Masonry

使用方法

/**
 *  初始化方法
 *
 *  @param title                  标题
 *  @param descriptive            描述文字
 *  @param cancelButtonTitle      取消按钮文字
 *  @param destructiveButtonTitles 特殊文字（红色可点击菜单),需传入数组
                                    PS:首先检查otherButtonTitles是否有相同字段。没有创建，有则代替。
 *  @param otherButtonTitles      其他按钮（蓝色可点击菜单),需传入数组
 *  @param itemAction             点击事件
 *
 *  @return self
 */
      
    - (instancetype)initActionSheetWithTitle:(NSString *)title
                         descriptiveText:(NSString *)descriptive
                       cancelButtonTitle:(NSString *)cancelButtonTitle
                 destructiveButtonTitles:(NSArray *)destructiveButtonTitles
                       otherButtonTitles:(NSArray *)otherButtonTitles
                              itemAction:(void(^)(HBActionSheet *actionSheet, NSString *title, NSInteger index))itemAction;
