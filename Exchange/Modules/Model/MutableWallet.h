//
//  MutableWallet.h
//  Exchange
//
//  Created by Константин on 14.02.17.
//  Copyright © 2017 KYurichev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Wallet.h"

@interface MutableWallet: NSObject

@property (readonly, nonatomic, copy) Wallet *wallet;

- (instancetype)initWithWallet:(Wallet *)wallet;

- (void)giveMoney:(Money *)money;
- (void)spendMoney:(Money *)money;

@end
