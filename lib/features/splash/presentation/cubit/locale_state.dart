part of 'lcoale_cubit.dart';

abstract class LocaleState extends Equatable {
  final Locale locale;
  const LocaleState(this.locale);

  @override
  List<Object> get props => [locale];
}

class ChangeLangState extends LocaleState {
  const ChangeLangState(Locale selectedLocale) : super(selectedLocale);

}
