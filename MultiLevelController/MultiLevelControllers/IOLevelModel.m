//
//  IOLevelModel.m
//  MultiLevelController
//
//  Created by changhailuo on 2018/3/3.
//  Copyright © 2018年 changhailuo. All rights reserved.
//

#import "IOLevelModel.h"

#define idPrefix @"IONode"

@implementation IOLevelModel

//MARK: - 第一次需要全部展示  遍历所有的数据 得到所有的模型
//模拟返回数据
+ (NSArray*)returnData{
    NSArray * array = @[@{@"name":@"node1",
                           @"subNode":@[
                                   @{@"name":@"node10"},
                                   @{@"name":@"node11"},
                                   @{@"name":@"node12",
                                     @"subNode":@[
                                             @{@"name":@"node120",
                                               @"subNode":@[
                                                             @{@"name":@"node1201",
                                                               @"subNode":@[
                                                                       @{@"name":@"node12010"}
                                                                       ]
                                                               }
                                                             ]
                                               }]
                                     }
                                   ]
                           },
                        @{@"name":@"node2",
                          @"subNode":@[
                                  @{@"name":@"node20"},
                                  @{@"name":@"node21"},
                                  @{@"name":@"node22",
                                    @"subNode":@[
                                            @{@"name":@"node220"}
                                            ]
                                    }
                                  ]
                          }
                        ];
    
    NSMutableArray * mutArray = [NSMutableArray array];
    
  //采用树的结构  标识node的父节点Id
    for (NSInteger i = 0 ; i < array.count ; i++) {
        IOLevelModel * model = [IOLevelModel new];
         //添加标识
        //第一层的是没有父节点的
        model.parentId = idPrefix;
        model.nodeId = [NSString stringWithFormat:@"%@%ld",idPrefix,i];
        model.level = 0;
        [model setValuesForKeysWithDictionary:array[i]];
        
        [mutArray addObject:model];
        
        [self retainDataWithModel:model byArray:mutArray];
    }
    
    
    [mutArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
    }];
    
    
    return mutArray;
}

/**
 递归遍历所有节点

 @param model root模型
 @param array 数据保存数组
 */
+(void)retainDataWithModel:(IOLevelModel * )model byArray:(NSMutableArray *)array{
    if (model.subNode.count > 0) {
        [array addObjectsFromArray:model.subNode];
        //遍历下一层
        for (IOLevelModel * subModel in model.subNode) {
            [self retainDataWithModel:subModel byArray:array];
        }
    }
}


/**
 系统KVC方法 在这里针对subNode处理

 @param value value
 @param key key
 */
-(void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"subNode"]) {
        for (NSInteger i = 0 ; i < ((NSArray *)value).count ; i++) {
            IOLevelModel * model = [IOLevelModel new];
            model.parentId = self.nodeId;
            model.nodeId = [NSString stringWithFormat:@"%@%ld",self.nodeId,i];
            model.level = self.level+1;
            [model setValuesForKeysWithDictionary:value[i]];
            [self.subNode addObject:model];
        }
    }else{
        [super setValue:value forKey:key];
    }
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


-(NSMutableArray *)subNode{
    if (!_subNode) {
        _subNode = [NSMutableArray array];
    }
    return _subNode;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"name = %@ , subNode = %@ , nodeId = %@",_name,_subNode,_nodeId];
}

@end
