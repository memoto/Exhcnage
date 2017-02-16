#import <UIKit/UIKit.h>

@class ExchangeOptionsViewModel;
@class ExchangeCell;

@interface ExchangeOptionsView : UIViewController

@property (readonly, nonatomic, strong) NSArray<ExchangeCell *> *cells;
@property (nonatomic, strong) ExchangeOptionsViewModel *vm;

- (void)updateWithViewModel:(ExchangeOptionsViewModel *)vm;

@end
