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

@interface MutableWallet ()

@property (readwrite, nonatomic, copy) Wallet *wallet;

@end

@implementation MutableWallet

- (instancetype)initWithWallet:(Wallet *)wallet {
    if (self) {
        self.wallet = wallet;
    }
    return self;
}

- (void)giveMoney:(Money *)money {
    let reversedAmount = [NSNumber numberWithDouble:-money.amount.doubleValue];
    let moneyToGive = [Money.alloc initWithCurrencyID:money.currencyID
                                            andAmount:reversedAmount];
    [self spendMoney:moneyToGive];
}

- (void)spendMoney:(Money *)moneyToSpend {
    // write accessor to our money collection
    let moneys = [NSMutableArray arrayWithArray:self.wallet.moneys];
    
    let money = [self.wallet moneyForCurrency:moneyToSpend.currencyID];
    if (money == nil) { return; }
    
    let index = [self.wallet indexOfCurrency:money.currencyID];
    let remainingMoney = [money moneyBySubstractingOther:moneyToSpend];
    
    if (remainingMoney.amount > 0) {
        moneys[index] = remainingMoney;
    }
    else {
        [moneys removeObjectAtIndex:index];
    }
    
    self.wallet.moneys = moneys;
}

@end
