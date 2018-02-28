//
//  UserInfoTableViewCell.m
//  FirstTry
//
//  Created by schooldave on 4/21/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "UserInfoTableViewCell.h"


@interface UserInfoTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *lblusername;
@property (weak, nonatomic) IBOutlet UILabel *lblname;
@property (weak, nonatomic) IBOutlet UILabel *lblidCardNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblphone;


@end

@implementation UserInfoTableViewCell

-(void)setUserInfo:(UserInfo *)userInfo
{
    _userInfo = userInfo;
    self.lblusername.text = userInfo.username;
    self.lblname.text = userInfo.name;
    self.lblidCardNumber.text = userInfo.idCardNumber;
    self.lblphone.text = userInfo.phone;
    
}





- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
