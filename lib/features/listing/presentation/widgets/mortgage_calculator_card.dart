import 'package:flutter/material.dart';

import '../../../../core/theme/design_tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/utils/mortgage.dart';

/// Interactive mortgage estimator. Recomputes the monthly payment live as the
/// user adjusts down payment, interest rate and term.
class MortgageCalculatorCard extends StatefulWidget {
  const MortgageCalculatorCard({super.key, required this.price});

  final double price;

  @override
  State<MortgageCalculatorCard> createState() => _MortgageCalculatorCardState();
}

class _MortgageCalculatorCardState extends State<MortgageCalculatorCard> {
  late double _downPaymentPct = 20;
  double _ratePct = 6.5;
  int _termYears = 30;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final downPayment = widget.price * _downPaymentPct / 100;
    final result = MortgageCalculator.compute(MortgageInput(
      price: widget.price,
      downPayment: downPayment,
      annualRatePercent: _ratePct,
      termYears: _termYears,
    ));

    return Card(
      child: Padding(
        padding: AppSpacing.pageAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.calculate_outlined, color: theme.colorScheme.primary),
                const SizedBox(width: AppSpacing.sm),
                Text('Mortgage estimate',
                    style: theme.textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Center(
              child: Column(
                children: [
                  Text(Formatters.currency(result.monthlyPayment),
                      style: theme.textTheme.headlineMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold)),
                  Text('per month',
                      style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant)),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            _SliderRow(
              label: 'Down payment',
              value: '${_downPaymentPct.round()}% · '
                  '${Formatters.currency(downPayment)}',
              slider: Slider(
                min: 0,
                max: 60,
                divisions: 60,
                value: _downPaymentPct,
                label: '${_downPaymentPct.round()}%',
                onChanged: (v) => setState(() => _downPaymentPct = v),
              ),
            ),
            _SliderRow(
              label: 'Interest rate',
              value: '${_ratePct.toStringAsFixed(1)}%',
              slider: Slider(
                min: 0,
                max: 12,
                divisions: 120,
                value: _ratePct,
                label: '${_ratePct.toStringAsFixed(1)}%',
                onChanged: (v) => setState(() => _ratePct = v),
              ),
            ),
            _SliderRow(
              label: 'Loan term',
              value: '$_termYears years',
              slider: Slider(
                min: 5,
                max: 30,
                divisions: 5,
                value: _termYears.toDouble(),
                label: '$_termYears yrs',
                onChanged: (v) => setState(() => _termYears = v.round()),
              ),
            ),
            const Divider(),
            _SummaryRow('Loan amount', Formatters.currency(result.loanAmount)),
            _SummaryRow(
                'Total interest', Formatters.currency(result.totalInterest)),
            _SummaryRow('Total paid', Formatters.currency(result.totalPaid)),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Estimate only. Taxes, insurance and fees are not included.',
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliderRow extends StatelessWidget {
  const _SliderRow(
      {required this.label, required this.value, required this.slider});
  final String label;
  final String value;
  final Widget slider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
            Text(value,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
          ],
        ),
        slider,
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(value,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
