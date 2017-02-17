//
//  ExchangeCell.m
//  Exchange
//
//  Created by Константин on 15.02.17.
//  Copyright © 2017 KYurichev. All rights reserved.
//

#import "ExchangeCell.h"
#import <UIKit/UIKit.h>
#import "ExchangeCellViewModel.h"
#import "ExchangeCellViewModel+ActionReducer.h"
#import "ExchangeCell+Updater.h"

#import "Wallet.h"
#import "Money.h"

@interface ExchangeCell ()

@end

@implementation ExchangeCell

+ (instancetype)cell {
    let storyboard = [UIStoryboard storyboardWithName:@"ExchangeCell" bundle:nil];
    let vc = [storyboard instantiateInitialViewController];
    
    return vc;
}

-(void) awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViewModel];
}

- (void)setVm:(ExchangeCellViewModel *)vm {
    _vm = vm;
    
    [self updateWithViewModel:vm];
}

- (void)configureViewModel {
    if (self.vm == nil) {
        self.vm = [ExchangeCellViewModel.alloc initWithCurrency:nil andMoney:nil];
    }
    __weak ExchangeCell *welf = self;
    // bindings
    let prevDidChange = self.vm.didChange;
    self.vm.didChange = ^(ExchangeCellViewModel *vm){
        [welf updateWithViewModel:vm];
        
        if (prevDidChange) {
            prevDidChange(vm);
        }
    };
    self.vm.didConverted = ^(ExchangeCellViewModel *vm){
        [welf updateWithViewModel:vm];
    };
    //
    [self updateWithViewModel:self.vm];
}

- (IBAction)didBeginEditing:(id)sender {
    [self.vm didBeginBidInput];
}

- (IBAction)didFinishEditing:(id)sender {
    [self.vm bidInput:self.amountEdit.text];
}

@end
