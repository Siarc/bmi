import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/bmi_result.dart';
import 'calculator_event.dart';
import 'calculator_state.dart';

/// BLoC for the BMI Calculator feature.
/// Handles all calculator input changes and BMI computation.
class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(const CalculatorState()) {
    on<GenderChanged>(_onGenderChanged);
    on<AgeChanged>(_onAgeChanged);
    on<HeightFeetChanged>(_onHeightFeetChanged);
    on<HeightInchesChanged>(_onHeightInchesChanged);
    on<HeightCmChanged>(_onHeightCmChanged);
    on<WeightLbsChanged>(_onWeightLbsChanged);
    on<WeightKgChanged>(_onWeightKgChanged);
    on<UnitSystemChanged>(_onUnitSystemChanged);
    on<CalculateBmiRequested>(_onCalculateBmi);
    on<CalculatorReset>(_onReset);
  }

  void _onGenderChanged(GenderChanged event, Emitter<CalculatorState> emit) {
    emit(state.copyWith(gender: event.gender, clearResult: true));
  }

  void _onAgeChanged(AgeChanged event, Emitter<CalculatorState> emit) {
    emit(state.copyWith(age: event.age, clearResult: true));
  }

  void _onHeightFeetChanged(
    HeightFeetChanged event,
    Emitter<CalculatorState> emit,
  ) {
    final totalInches = (event.feet * 12) + state.heightInches;
    final cm = totalInches * 2.54;
    emit(state.copyWith(
      heightFeet: event.feet,
      heightCm: double.parse(cm.toStringAsFixed(1)),
      clearResult: true,
    ));
  }

  void _onHeightInchesChanged(
    HeightInchesChanged event,
    Emitter<CalculatorState> emit,
  ) {
    final totalInches = (state.heightFeet * 12) + event.inches;
    final cm = totalInches * 2.54;
    emit(state.copyWith(
      heightInches: event.inches,
      heightCm: double.parse(cm.toStringAsFixed(1)),
      clearResult: true,
    ));
  }

  void _onHeightCmChanged(
    HeightCmChanged event,
    Emitter<CalculatorState> emit,
  ) {
    final totalInches = event.heightCm / 2.54;
    final feet = (totalInches / 12).floor();
    final inches = (totalInches % 12).round();
    
    emit(state.copyWith(
      heightCm: event.heightCm,
      heightFeet: feet,
      heightInches: inches,
      clearResult: true,
    ));
  }

  void _onWeightLbsChanged(
    WeightLbsChanged event,
    Emitter<CalculatorState> emit,
  ) {
    final kg = event.weightLbs * 0.453592;
    emit(state.copyWith(
      weightLbs: event.weightLbs,
      weightKg: double.parse(kg.toStringAsFixed(1)),
      clearResult: true,
    ));
  }

  void _onWeightKgChanged(
    WeightKgChanged event,
    Emitter<CalculatorState> emit,
  ) {
    final lbs = event.weightKg / 0.453592;
    emit(state.copyWith(
      weightKg: event.weightKg,
      weightLbs: double.parse(lbs.toStringAsFixed(1)),
      clearResult: true,
    ));
  }

  void _onUnitSystemChanged(
    UnitSystemChanged event,
    Emitter<CalculatorState> emit,
  ) {
    emit(state.copyWith(isMetric: event.isMetric, clearResult: true));
  }

  void _onCalculateBmi(
    CalculateBmiRequested event,
    Emitter<CalculatorState> emit,
  ) {
    if (!state.canCalculate) return;

    emit(state.copyWith(isCalculating: true));

    final heightCm = state.heightInCm;
    final weightKg = state.weightInKg;
    final bmi = BmiResult.calculateBmi(heightCm, weightKg);
    final category = BmiResult.getCategory(bmi);

    final result = BmiResult(
      height: heightCm,
      weight: weightKg,
      bmi: bmi,
      category: category,
      date: DateTime.now(),
      gender: state.gender,
      age: state.age,
    );

    emit(state.copyWith(result: result, isCalculating: false));
  }

  void _onReset(CalculatorReset event, Emitter<CalculatorState> emit) {
    emit(const CalculatorState());
  }
}
