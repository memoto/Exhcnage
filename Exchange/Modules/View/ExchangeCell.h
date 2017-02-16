//
//  ExchangeCell.h
//  Exchange
//
//  Created by Константин on 15.02.17.
//  Copyright © 2017 KYurichev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ExchangeCellViewModel;

@interface ExchangeCell : UIViewController

@property (strong, nonatomic) ExchangeCellViewModel *vm;

@property (weak, nonatomic) IBOutlet UILabel *currencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;
@property (weak, nonatomic) IBOutlet UITextField *amountEdit;
@property (weak, nonatomic) IBOutlet UILabel *ratioLabel;

+ (instancetype)cell;

@end
