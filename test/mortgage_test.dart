import 'package:dwellio/core/utils/mortgage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MortgageCalculator', () {
    test('computes the standard amortized monthly payment', () {
      // $300k loan ($375k - 20% down), 6% APR, 30 years.
      final result = MortgageCalculator.compute(const MortgageInput(
        price: 375000,
        downPayment: 75000,
        annualRatePercent: 6,
        termYears: 30,
      ));

      expect(result.loanAmount, 300000);
      // Known closed-form value ≈ $1798.65/mo.
      expect(result.monthlyPayment, closeTo(1798.65, 0.5));
      // Total paid = monthly * 360.
      expect(result.totalPaid, closeTo(result.monthlyPayment * 360, 0.01));
      expect(result.totalInterest,
          closeTo(result.totalPaid - result.loanAmount, 0.01));
    });

    test('falls back to straight-line division at 0% interest', () {
      final result = MortgageCalculator.compute(const MortgageInput(
        price: 120000,
        downPayment: 0,
        annualRatePercent: 0,
        termYears: 10,
      ));

      // 120000 / (10 * 12) = 1000 exactly, no interest.
      expect(result.monthlyPayment, 1000);
      expect(result.totalInterest, 0);
    });

    test('returns zero when the loan is fully covered by the down payment', () {
      final result = MortgageCalculator.compute(const MortgageInput(
        price: 200000,
        downPayment: 200000,
        annualRatePercent: 5,
        termYears: 30,
      ));

      expect(result.loanAmount, 0);
      expect(result.monthlyPayment, 0);
      expect(result.totalPaid, 0);
    });

    test('higher rate yields a higher monthly payment', () {
      MortgageResult at(double rate) =>
          MortgageCalculator.compute(MortgageInput(
            price: 400000,
            downPayment: 80000,
            annualRatePercent: rate,
            termYears: 30,
          ));

      expect(at(7).monthlyPayment, greaterThan(at(4).monthlyPayment));
    });
  });
}
