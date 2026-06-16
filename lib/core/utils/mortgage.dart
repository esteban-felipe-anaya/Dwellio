import 'dart:math' as math;

/// Inputs for a monthly mortgage estimate.
class MortgageInput {
  const MortgageInput({
    required this.price,
    required this.downPayment,
    required this.annualRatePercent,
    required this.termYears,
  });

  final double price;
  final double downPayment;
  final double annualRatePercent;
  final int termYears;

  double get loanAmount => math.max(0, price - downPayment);
}

/// Result of a mortgage calculation.
class MortgageResult {
  const MortgageResult({
    required this.monthlyPayment,
    required this.loanAmount,
    required this.totalInterest,
    required this.totalPaid,
  });

  final double monthlyPayment;
  final double loanAmount;
  final double totalInterest;
  final double totalPaid;
}

/// Pure mortgage math — fully unit-tested.
///
/// Uses the standard amortization formula:
///   M = P · r / (1 − (1 + r)^(−n))
/// where `r` is the monthly interest rate and `n` the number of payments.
/// Falls back to straight-line division when the rate is zero.
class MortgageCalculator {
  const MortgageCalculator._();

  static MortgageResult compute(MortgageInput input) {
    final principal = input.loanAmount;
    final n = input.termYears * 12;

    if (principal <= 0 || n <= 0) {
      return const MortgageResult(
        monthlyPayment: 0,
        loanAmount: 0,
        totalInterest: 0,
        totalPaid: 0,
      );
    }

    final r = input.annualRatePercent / 100 / 12;

    final double monthly;
    if (r == 0) {
      monthly = principal / n;
    } else {
      final factor = math.pow(1 + r, -n).toDouble();
      monthly = principal * r / (1 - factor);
    }

    final totalPaid = monthly * n;
    return MortgageResult(
      monthlyPayment: monthly,
      loanAmount: principal,
      totalInterest: totalPaid - principal,
      totalPaid: totalPaid,
    );
  }
}
