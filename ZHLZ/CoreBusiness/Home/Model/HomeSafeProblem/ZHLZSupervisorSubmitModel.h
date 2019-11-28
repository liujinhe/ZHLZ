//
//  ZHLZSupervisorSubmitModel.h
//  ZHLZ
//
//  Created by apple on 2019/11/26.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZSupervisorSubmitModel : ZHLZBaseModel

/*[{"meadate":"2019-11-26","meCustomize":"于2019-11-26对该问题进行\"召集会议,责令改正,微信/电话督办\"的措施","book":"3n4n5","uuid":"Gn34CEwl","isexport":"1"},{"meadate":"2019-11-26","meCustomize":"于2019-11-26对该问题进行\"召集会议,移交/告知/通知（其他职能部门）\"的措施","book":"3n6","uuid":"puyrTjDZ","isexport":"1"}]
 
 */
@property (nonatomic , strong) NSString *meadate;///时间
@property (nonatomic , strong) NSString *meCustomize;///督导字符串
@property (nonatomic , strong) NSString *book;///督导code
@property (nonatomic , strong) NSString *uuid;///uuid随机c生成
@property (nonatomic , strong) NSString *isexport;///是否导出

@end

NS_ASSUME_NONNULL_END
