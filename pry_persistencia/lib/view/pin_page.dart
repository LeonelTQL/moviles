import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_styles.dart';
import '../core/widgets/custom_app_bar.dart';
import '../core/widgets/custom_button.dart';
import '../core/widgets/custom_card.dart';
import '../core/widgets/custom_elevated_button.dart';
import '../core/widgets/custom_icon.dart';
import '../core/widgets/custom_text.dart';

import '../viewmodel/pin_viewmodel.dart';
import 'home_page.dart';

class PinPage extends StatefulWidget {
  const PinPage({super.key});

  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;
      context.read<PinViewModel>().loadPin();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PinViewModel>();

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'PIN de Acceso',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 25),

              CustomText(
                text: 'Ingresa el PIN',
                style: AppStyles.title,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              CustomCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _pinCircle(viewModel.enteredPin.length, 0),
                    _pinCircle(viewModel.enteredPin.length, 1),
                    _pinCircle(viewModel.enteredPin.length, 2),
                    _pinCircle(viewModel.enteredPin.length, 3),

                    const SizedBox(width: 18),

                    IconButton(
                      onPressed: viewModel.deleteLastNumber,
                      icon: const CustomIcon(
                        icon: Icons.backspace_outlined,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              _numberRow(['1', '2', '3']),
              const SizedBox(height: 12),

              _numberRow(['4', '5', '6']),
              const SizedBox(height: 12),

              _numberRow(['7', '8', '9']),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _numberButton('0'),
                ],
              ),

              const SizedBox(height: 18),

              CustomText(
                text: viewModel.message,
                style: viewModel.isCorrect
                    ? AppStyles.subtitle.copyWith(
                  color: AppColors.secondary,
                )
                    : AppStyles.subtitle.copyWith(
                  color: AppColors.error,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 28),

              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      text: 'Olvidé mi PIN',
                      onPressed: () => viewModel.resetPin(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomElevatedButton(
                      text: 'Cambiar PIN',
                      onPressed: () => viewModel.updatePin(viewModel.enteredPin),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _numberRow(List<String> numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: numbers.map((number) {
        return _numberButton(number);
      }).toList(),
    );
  }

  Widget _numberButton(String number) {
    final viewModel = context.read<PinViewModel>();

    return SizedBox(
      width: 85,
      child: CustomButton(
        text: number,
        onPressed: () {
          final isCorrect = viewModel.addNumber(number);

          if (isCorrect) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const HomePage(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _pinCircle(int length, int index) {
    final isFilled = index < length;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isFilled ? AppColors.primary : Colors.transparent,
        border: Border.all(
          color: AppColors.primary,
          width: 2,
        ),
      ),
    );
  }
}