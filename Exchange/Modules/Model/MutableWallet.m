//
//  MutableWallet.m
//  Exchange
//
//  Created by Константин on 14.02.17.
//  Copyright © 2017 KYurichev. All rights reserved.
//

#import "Wallet+Private.h"
#import "MutableWallet.h"
#import "Money.h"

@implementation MutableWallet

- (void)spendMoney:(Money *)moneyToSpend {
    // write accessor to our money collection
    let moneys = [NSMutableArray arrayWithArray:self.moneys];
    
    let money = [self moneyForCurrency:moneyToSpend.currencyID];
    if (money == nil) { return; }
    
    let index = [self indexOfCurrency:money.currencyID];
    let remainingMoneyAmount = money.amount.doubleValue - moneyToSpend.amount.doubleValue;
    
    let remainingMoney = [Money.alloc initWithCurrencyID:money.currencyID
                                               andAmount: [NSNumber numberWithDouble:remainingMoneyAmount]];
    if (remainingMoney.amount > 0) {
        moneys[index] = remainingMoney;
    }
    else {
        [moneys removeObjectAtIndex:index];
    }
    
    self.moneys = moneys;
}

@end
