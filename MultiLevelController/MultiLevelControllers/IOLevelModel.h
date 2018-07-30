//
//  IOLevelModel.h
//  MultiLevelController
//
//  Created by changhailuo on 2018/3/3.
//  Copyright © 2018年 changhailuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IOLevelModel : NSObject

@property(nonatomic,copy)NSString * name;

@property(nonatomic,strong)NSMutableArray * subNode;

@property(nonatomic,assign)BOOL isClose;

@property(nonatomic,copy)NSString * parentId;

@property(nonatomic,copy)NSString * nodeId;

@property(nonatomic,assign)NSInteger level;

+(NSArray *)returnData;

+(void)retainDataWithModel:(IOLevelModel * )model byArray:(NSMutableArray *)array;

@end
