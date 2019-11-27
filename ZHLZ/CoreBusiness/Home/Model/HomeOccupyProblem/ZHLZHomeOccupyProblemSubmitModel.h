//
//  ZHLZHomeOccupyProblemSubmitModel.h
//  ZHLZ
//
//  Created by apple on 2019/11/27.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

// /**问题类型**/
//private String protype;
///**问题发现时间**/
//private String prodate;
///**经办人**/
//private String promanager; //获取当前用户即可
///**问题描述**/
//private String prodescription;
///**备注**/
//private String responsibleUnit;
///**大队id**/
//private String orgid;
///**片区id**/
//private String areaid;
///**uploadid**/
//private String uploadid;
///**项目id**/
//private String projectid;
///**项目名称**/
//private String projectname;
///**责任区县id**/
//private String belong;
///**问题id**/
//private String proid;   //如果为保存  proid = “”   修改操作  proid = 所选问题id
///**督导措施具体描述**/
//private String ddssjtms;  //传空即可
///**问题标签**/
//private String label;   //一个输入框，他自己填写


@interface ZHLZHomeOccupyProblemSubmitModel : ZHLZBaseModel

@property (nonatomic, strong) NSString *protype;
@property (nonatomic, strong) NSString *prodate;
@property (nonatomic, strong) NSString *promanager;
@property (nonatomic, strong) NSString *prodescription;
@property (nonatomic, strong) NSString *responsibleUnit;
@property (nonatomic, strong) NSString *orgid;
@property (nonatomic, strong) NSString *areaid;
@property (nonatomic, strong) NSString *uploadid;
@property (nonatomic, strong) NSString *projectid;
@property (nonatomic, strong) NSString *projectname;
@property (nonatomic, strong) NSString *belong;
@property (nonatomic, strong) NSString *proid;
@property (nonatomic, strong) NSString *ddssjtms;
@property (nonatomic, strong) NSString *label;

@end

NS_ASSUME_NONNULL_END
