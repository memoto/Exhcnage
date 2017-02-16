#import "ExchangeCell+Updater.h"
#import "ExchangeCellViewModel.h"
#import "Money.h"

@implementation ExchangeCell (Updater)

- (void)updateWithViewModel:(ExchangeCellViewModel *)vm {
    if (vm.isEmpty) {
        [self updateWithEmptyState];
        return;
    }
    
    self.currencyLabel.text = vm.money.currencyID;
    self.hintLabel.text = vm.remainingMoneyText;
    self.hintLabel.textColor = vm.isOutOfBudget
                                ? UIColor.redColor
                                : UIColor.whiteColor;
    
    self.amountEdit.text = vm.bidText;
    self.ratioLabel.text =  vm.ratio;
}

- (void)updateWithEmptyState {
    // TODO: Show placeholder
}

@end
