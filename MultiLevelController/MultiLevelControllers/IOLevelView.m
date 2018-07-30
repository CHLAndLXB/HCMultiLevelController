//
//  IOLevelView.m
//  MultiLevelController
//
//  Created by changhailuo on 2018/3/3.
//  Copyright © 2018年 changhailuo. All rights reserved.
//

#import "IOLevelView.h"
#import "IOLevelModel.h"
#define cellIdentifier @"IOCell"

@interface IOLevelView()

@property(nonatomic,strong)NSMutableArray * allNodes;

@end

@implementation IOLevelView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.tableView.frame = self.frame;
    [self addSubview:_tableView];
    
    [self.dataArray addObjectsFromArray:[IOLevelModel returnData]];
    
    _allNodes = [NSMutableArray array];
    [_allNodes addObjectsFromArray:self.dataArray];
    
    [self.tableView reloadData];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    }
    return _tableView;
}


#pragma mark - delegate DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    IOLevelModel * model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击父节点  子节点收起
    
    IOLevelModel * model = self.dataArray[indexPath.row];
    
    [self.reloadArray removeAllObjects];
    
    if (model.subNode.count>0) {
        if (model.isClose) {
            //打开
            NSMutableArray * nodes = [NSMutableArray array];
            [self reloadSubNodeWithParentId:model.nodeId ByNodes:nodes];
            NSIndexSet * set = [[NSIndexSet alloc]initWithIndexesInRange:NSMakeRange(indexPath.row+1, nodes.count)];
            [self.dataArray insertObjects:nodes atIndexes:set];
            [tableView insertRowsAtIndexPaths:self.reloadArray  withRowAnimation:UITableViewRowAnimationNone];
        }else{
            //收起
            NSArray * reloadArray = [self reloadSubNodeWithLevel:model.level andCurrentIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:reloadArray withRowAnimation:UITableViewRowAnimationNone];
        }
        model.isClose = !model.isClose;
    }
}


/**
 递归查找子节点

 @param parentId 当前的父节点id
 @param nodes 保存的数组
 */
-(void)reloadSubNodeWithParentId:(NSString *)parentId ByNodes:(NSMutableArray *)nodes{
    for (NSInteger i = 0; i < self.allNodes.count; i++) {
        IOLevelModel * subModel = self.allNodes[i];
        if ([subModel.parentId isEqualToString:parentId]) {
            //以及它的子类都要收起
            [self.reloadArray addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            [nodes addObject:subModel];
            //递归查找
            if (subModel.isClose) {
                break;
            }
            [self reloadSubNodeWithParentId:subModel.nodeId ByNodes:nodes];
        }
    }
}


/**
 按级查找需要删除的部分

 @param level 当前节点的深度
 @param currentIndex 当前点击的下标
 @return 需要刷新的indexPath数组
 */
-(NSArray *)reloadSubNodeWithLevel:(NSInteger)level andCurrentIndex:(NSInteger)currentIndex{
    if (currentIndex+1<self.dataArray.count) {
        NSMutableArray *tempArr = [self.dataArray copy];
        for (NSUInteger i = currentIndex+1 ; i<tempArr.count;i++) {
            IOLevelModel *node = tempArr[i];
            if (node.level <= level) {
                break;
            }else{
                [self.dataArray removeObject:node];
                [self.reloadArray addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            }
        }
    }
    return self.reloadArray;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(NSMutableArray *)reloadArray{
    if (!_reloadArray) {
        _reloadArray = [NSMutableArray array];
    }
    return _reloadArray;
}

@end
