import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:one_admax_flutter_example/viewmodel/mediation_viewmodel.dart';

import '../model/native.dart';
import '../model/mediation.dart';
import '../viewmodel/native_platform_viewmodel.dart';
import '../widget/choice_widget.dart';

class NativeChoiceDetail extends ConsumerWidget {
  const NativeChoiceDetail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mediationProvider);

    switch (state.mediation) {
      case Mediation.pure:
        return ChoiceWidget(
          title: 'Native Ad',
          firstButtonTitle: 'Platform Ad',
          secondButtonTitle: 'Pure Template Ad',
          firstButtonClicked: () => context.go('/native/platform'),
          secondButtonClicked: () => context.go('/native/template'),
        );
      default:
        // 기본 케이스에서 기본 페이지로 이동한 후 빈 컨테이너를 반환합니다.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (ModalRoute.of(context)?.isCurrent ?? false) {
            context.go('/native/platform');
          }
        });
        return const SizedBox.shrink();
    }
  }
}
