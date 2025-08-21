/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/view_state_model.dart';

export 'package:flutter_riverpod/flutter_riverpod.dart' show WidgetRef;

typedef ProviderWidgetBuilder<T> = Widget Function(
    BuildContext context, T model, WidgetRef ref, Widget? child);
typedef ProviderWidgetBuilder2<A, B> = Widget Function(
    BuildContext context, A model1, B model2, WidgetRef ref, Widget? child);

/// Provider封装类
class ProviderWidget<T extends ViewStateModel?> extends ConsumerStatefulWidget {
  final ProviderListenable<T> provider;
  final ProviderWidgetBuilder<T> builder;
  final Widget? child;
  final Function(T model)? onModelReady;

  const ProviderWidget({
    super.key,
    required this.provider,
    required this.builder,
    this.child,
    this.onModelReady,
  });

  @override
  ProviderWidgetState<T> createState() => ProviderWidgetState<T>();
}

class ProviderWidgetState<T extends ViewStateModel?>
    extends ConsumerState<ProviderWidget<T>> {
  get child => widget.child;
  @override
  void initState() {
    super.initState();
    final model = ref.read<T>(widget.provider);
    //组件渲染后进行操作
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onModelReady?.call(model);
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.watch<T>(widget.provider);
    return widget.builder(context, model, ref, child);
  }
}

class ProviderWidget2<A extends ViewStateModel?, B extends ViewStateModel?>
    extends ConsumerStatefulWidget {
  final ProviderListenable<A> provider1;
  final ProviderListenable<B> provider2;
  final ProviderWidgetBuilder2<A, B> builder;
  final Widget? child;
  final Function(A model1, B model2)? onModelReady;

  const ProviderWidget2({
    super.key,
    required this.provider1,
    required this.provider2,
    required this.builder,
    this.child,
    this.onModelReady,
  });

  @override
  ProviderWidgetState2<A, B> createState() => ProviderWidgetState2<A, B>();
}

class ProviderWidgetState2<A extends ViewStateModel?, B extends ViewStateModel?>
    extends ConsumerState<ProviderWidget2<A, B>> {
  get child => widget.child;
  @override
  void initState() {
    super.initState();
    final model1 = ref.read<A>(widget.provider1);
    final model2 = ref.read<B>(widget.provider2);
    //组件渲染后进行操作
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onModelReady?.call(model1, model2);
    });
  }

  @override
  Widget build(BuildContext context) {
    final model1 = ref.watch<A>(widget.provider1);
    final model2 = ref.watch<B>(widget.provider2);

    return widget.builder(context, model1, model2, ref, child);
  }
}
