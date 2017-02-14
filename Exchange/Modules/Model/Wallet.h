//
//  Wallet.h
//  Exchange
//
//  Created by Константин on 14.02.17.
//  Copyright © 2017 KYurichev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Money;

@interface Wallet : NSObject

@property (readonly, nonatomic, strong) NSArray<Money *> *moneys;

- (Money *)moneyForCurrency:(NSString *)currencyID;
- (BOOL)hasMoney:(Money *)requiredMoney;

@end
