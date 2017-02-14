//
//  MutableWallet.h
//  Exchange
//
//  Created by Константин on 14.02.17.
//  Copyright © 2017 KYurichev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Wallet.h"

@interface MutableWallet : Wallet

- (instancetype)initWithWallet:(Wallet *)wallet;

- (void)spendMoney:(Money *)money;

@end
