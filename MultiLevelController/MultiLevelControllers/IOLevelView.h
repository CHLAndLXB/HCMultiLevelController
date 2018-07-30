//
//  IOLevelView.h
//  MultiLevelController
//
//  Created by changhailuo on 2018/3/3.
//  Copyright © 2018年 changhailuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IOLevelView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)NSMutableArray * dataArray;

@property(nonatomic,strong)NSMutableArray * reloadArray;
@end
