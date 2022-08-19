import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../core/widgets/error_widget.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../cubits/quotes_cubit.dart';
import '../components/quote_content.dart';

class QuoteScreen extends StatelessWidget {
  const QuoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
      ),
      body: BlocBuilder<QuotesCubit, QuotesState>(
        builder: (context, state) {
          final cubit = BlocProvider.of<QuotesCubit>(context);
          if (state is QuotesLoadingState) {
            return Center(
              child: SpinKitFadingCircle(
                color: AppColors.primary,
              ),
            );
          } else if (state is QuotesSuccessState) {
            return RefreshIndicator(
              onRefresh: ()=> cubit.getRandomQuotes(),
              child: Column(
                children: [
                  QuoteContent(quote: state.quote),
                  InkWell(
                    onTap: () => cubit.getRandomQuotes(),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 25),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                      ),
                      child: Icon(
                        Icons.refresh,
                        size: 30,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is QuotesErrorState) {
            return ErrorWidgets(onPressed: () async{
              return cubit.getRandomQuotes();
            });
          } else {
            return Center(
              child: SpinKitFadingCircle(
                color: AppColors.primary,
              ),
            );
          }
        },
      ),
    );
  }
}
