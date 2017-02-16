#import "ExchangeOptionsView+PagerDataSource.h"
#import "ExchangeOptionsViewModel.h"
#import "ExchangeOptionsView.h"
#import "ExchangeCell.h"
#import "ExchangeCellViewModel.h"
#import "Money.h"

@implementation ExchangeOptionsView (PagerDataSource)

- (ExchangeCell *)nextCellAfter:(ExchangeCell *)cell inForwardDirection:(BOOL)isForward {
    NSInteger currentIndex = [self.vm.options indexOfObjectPassingTest:
                              ^BOOL(ExchangeCellViewModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                  
                                  return [obj.money.currencyID isEqualToString:cell.vm.money.currencyID];
                              }];
    let diff = isForward ? 1 : -1;
    let nextIndex = currentIndex + diff;
    let startIndex = 0;
    let endIndex = self.cells.count - 1;
    let isInRange = nextIndex <= endIndex && nextIndex >= startIndex;
    let recoveredNextIndex = isInRange
    ? nextIndex
    : nextIndex < startIndex
    ? endIndex
    : startIndex;
    let nextCell = self.cells[recoveredNextIndex];
    
    return nextCell;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    let cell = (ExchangeCell *)viewController;
    
    return [self nextCellAfter:cell inForwardDirection:YES];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    let cell = (ExchangeCell *)viewController;
    
    return [self nextCellAfter:cell inForwardDirection:NO];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    
    return self.cells.count;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    
    return 0;
}

@end
