// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:bottom_sheet/src/flexible_bottom_sheet_header_delegate.dart';
import 'package:bottom_sheet/src/widgets/flexible_bottom_sheet_scroll_notifyer.dart';
import 'package:bottom_sheet/src/widgets/flexible_draggable_scrollable_sheet.dart';
import 'package:flutter/material.dart';

/// Flexible and scrollable bottom sheet.
///
/// This bottom sheet resizing between min and max size, and when size become
/// max start scrolling content. Reduction size available when content
/// scrolled to 0 offset.
///
/// [minHeight], [maxHeight] are limits of
/// bounds this widget. For example:
/// - you can set  [maxHeight] to 1;
/// - you can set [minHeight] to 0.5;
///
/// [isCollapsible] make possible collapse widget and remove from the screen,
/// but you must be carefully to use it, set it to true only if you show this
/// widget with like showFlexibleBottomSheet() case, because it will be removed
/// by Navigator.pop(). If you set [isCollapsible] true, [minHeight]
/// must be 0.
///
/// The [animationController] that controls the bottom sheet's entrance and
/// exit animations.
/// The FlexibleBottomSheet widget will manipulate the position of this
/// animation, it is not just a passive observer.
///
/// [initHeight] - relevant height for init bottom sheet
class FlexibleBottomSheet extends StatefulWidget {
  const FlexibleBottomSheet({
    Key key,
    this.minHeight = 0,
    this.initHeight = 0.5,
    this.maxHeight = 1,
    this.builder,
    this.headerBuilder,
    this.bodyBuilder,
    this.isCollapsible = false,
    this.isExpand = true,
    this.animationController,
    this.anchors,
    this.minHeaderHeight,
    this.maxHeaderHeight,
    this.decoration,
    this.onDismiss,
  })  : assert(minHeight >= 0 && minHeight <= 1),
        assert(maxHeight > 0 && maxHeight <= 1),
        assert(maxHeight > minHeight),
        assert(!isCollapsible || minHeight == 0),
        super(key: key);

  const FlexibleBottomSheet.collapsible({
    Key key,
    double initHeight = 0.5,
    double maxHeight = 1,
    FlexibleDraggableScrollableWidgetBuilder builder,
    FlexibleDraggableScrollableHeaderWidgetBuilder headerBuilder,
    FlexibleDraggableScrollableWidgetBodyBuilder bodyBuilder,
    bool isExpand = true,
    AnimationController animationController,
    List<double> anchors,
    double minHeaderHeight,
    double maxHeaderHeight,
    Decoration decoration,
  }) : this(
          key: key,
          maxHeight: maxHeight,
          builder: builder,
          headerBuilder: headerBuilder,
          bodyBuilder: bodyBuilder,
          minHeight: 0,
          initHeight: initHeight,
          isCollapsible: true,
          isExpand: isExpand,
          animationController: animationController,
          anchors: anchors,
          minHeaderHeight: minHeaderHeight,
          maxHeaderHeight: maxHeaderHeight,
          decoration: decoration,
        );

  final double minHeight;
  final double initHeight;
  final double maxHeight;
  final FlexibleDraggableScrollableWidgetBuilder builder;
  final FlexibleDraggableScrollableHeaderWidgetBuilder headerBuilder;
  final FlexibleDraggableScrollableWidgetBodyBuilder bodyBuilder;
  final bool isCollapsible;
  final bool isExpand;
  final AnimationController animationController;
  final List<double> anchors;
  final double minHeaderHeight;
  final double maxHeaderHeight;
  final Decoration decoration;
  final VoidCallback onDismiss;

  @override
  _FlexibleBottomSheetState createState() => _FlexibleBottomSheetState();
}

class _FlexibleBottomSheetState extends State<FlexibleBottomSheet>
    with SingleTickerProviderStateMixin {
  bool _isClosing = false;

  AnimationController _animationController;
  final _topOffsetTween = Tween<double>();

  double _currentAnchor;

  FlexibleDraggableScrollableSheetScrollController _controller;

  Animation<double> _topTweenAnimation;
  VoidCallback _animationListener;
  void Function(AnimationStatus) _statusListener;

  bool _isKeyboardOpenedNotified = false;
  bool _isKeyboardClosedNotified = false;

  double get _currentExtent => _controller.extent.currentExtent;

  @override
  void initState() {
    super.initState();

    _currentAnchor = widget.initHeight;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    final curve = CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    );
    _topTweenAnimation = _topOffsetTween.animate(curve);
    _statusListener = (status) {
      if (status == AnimationStatus.completed) {
        _controller.extent.currentExtent = _currentAnchor;
        _animationController.reset();
      }
    };
    _animationListener = () {
      if (_animationController.isAnimating) {
        _controller.extent.currentExtent = _topTweenAnimation.value;
      }
    };
    _topTweenAnimation
      ..addListener(_animationListener)
      ..addStatusListener(_statusListener);
  }

  @override
  Widget build(BuildContext context) {
    _checkKeyboard();

    return FlexibleScrollNotifyer(
      scrollStartCallback: _startScroll,
      scrollingCallback: _scrolling,
      scrollEndCallback: _endScroll,
      child: FlexibleDraggableScrollableSheet(
        maxChildSize: widget.maxHeight,
        minChildSize: widget.minHeight,
        initialChildSize: widget.initHeight,
        builder: (
          context,
          controller,
        ) {
          _controller =
              controller as FlexibleDraggableScrollableSheetScrollController;

          return AnimatedPadding(
            duration: const Duration(milliseconds: 100),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: _buildContent(context),
          );
        },
        expand: widget.isExpand,
      ),
    );
  }

  // ignore: avoid-returning-widgets
  Widget _buildContent(BuildContext context) {
    if (widget.builder != null) {
      return widget.builder(
        context,
        _controller,
        _controller.extent.currentExtent,
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          decoration: widget.decoration,
          child: CustomScrollView(
            controller: _controller,
            slivers: <Widget>[
              if (widget.headerBuilder != null)
                SliverPersistentHeader(
                  pinned: true,
                  delegate: FlexibleBottomSheetHeaderDelegate(
                    minHeight: widget.minHeaderHeight ?? 0.0,
                    maxHeight: widget.maxHeaderHeight ?? 1.0,
                    child: widget.headerBuilder(context, _currentExtent),
                  ),
                ),
              if (widget.bodyBuilder != null)
                SliverList(
                  delegate: widget.bodyBuilder(
                    context,
                    _currentExtent,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _topTweenAnimation
      ..removeListener(_animationListener)
      ..removeStatusListener(_statusListener);

    super.dispose();
  }

  void _checkKeyboard() {
    if (MediaQuery.of(context).viewInsets.bottom != 0) {
      if (!_isKeyboardOpenedNotified) {
        _isKeyboardOpenedNotified = true;
        _isKeyboardClosedNotified = false;
        _keyboardOpened();
      }
    } else {
      if (_isKeyboardOpenedNotified && !_isKeyboardClosedNotified) {
        _isKeyboardClosedNotified = true;
        _isKeyboardOpenedNotified = false;
        _keyboardClosed();
      }
    }
  }

  void _keyboardOpened() {
    final maxBottomSheetHeight = widget.maxHeight;

    _currentAnchor = maxBottomSheetHeight;
    _animateToNextAnchor(maxBottomSheetHeight);
    if (_currentAnchor == widget.maxHeight) {
      _preScroll();
    }
  }

  void _keyboardClosed() {}

  void _preScroll() {
    if (FocusManager.instance.primaryFocus == null) return;

    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    if (_controller.extent.currentExtent == widget.maxHeight &&
        keyboardHeight != 0) {
      final widgetOffset = FocusManager.instance.primaryFocus.offset.dy;
      final widgetHeight = FocusManager.instance.primaryFocus.size.height;
      final screenHeight = MediaQuery.of(context).size.height;

      final valueToScroll =
          keyboardHeight - (screenHeight - (widgetOffset + widgetHeight));
      if (valueToScroll > 0) {
        Future<void>.delayed(const Duration(milliseconds: 100)).then((_) {
          _controller.animateTo(
            _controller.offset + valueToScroll + 10,
            duration: const Duration(milliseconds: 200),
            curve: Curves.linear,
          );
        });
      }
    }
  }

  bool _startScroll(ScrollStartNotification notification) {
    return false;
  }

  bool _scrolling(FlexibleDraggableScrollableNotification notification) {
    if (_isClosing) return false;

    if (widget.isCollapsible && !_isClosing) {
      if (notification.extent == widget.minHeight) {
        setState(() {
          _isClosing = true;
          _dismiss();
        });
      }
    }

    final currentVal = notification.extent;
    var initVal = notification.initialExtent;

    if (initVal == 0) {
      initVal = currentVal;
    }

    if (widget.animationController != null) {
      widget.animationController.value =
          (1 + (currentVal - initVal) / initVal).clamp(0.0, 1.0);
    }

    _checkNeedCloseBottomSheet();

    return false;
  }

  bool _endScroll(ScrollEndNotification notification) {
    if (widget.anchors?.isNotEmpty ?? false) {
      _scrollToNearestAnchor(notification.dragDetails);
    }

    _checkNeedCloseBottomSheet();

    return false;
  }

  void _checkNeedCloseBottomSheet() {
    if (_controller.extent.currentExtent <= widget.minHeight && !_isClosing) {
      _isClosing = true;
      _dismiss();
    }
  }

  void _scrollToNearestAnchor(DragEndDetails oldDragDetails) {
    final screenAnchors = _screenAnchors;
    final nextAnchor = _calculateNextAnchor(screenAnchors);

    _animateToNextAnchor(nextAnchor);
    _currentAnchor = nextAnchor;
  }

  double _calculateNextAnchor(List<double> screenAnchor) {
    if (screenAnchor.contains(_controller.extent.currentExtent)) {
      return _controller.extent.currentExtent;
    }

    final nearestAnchor =
        _findNearestAnchors(screenAnchor, _controller.extent.currentExtent);
    final firstAnchor = nearestAnchor[0];
    final secondAnchor = nearestAnchor[1];

    if (firstAnchor == _currentAnchor) {
      return _findNextAnchorFromPrevious(firstAnchor, secondAnchor);
    } else if (secondAnchor == _currentAnchor) {
      return _findNextAnchorFromPrevious(secondAnchor, firstAnchor);
    } else {
      return (firstAnchor - _controller.extent.currentExtent).abs() >
              (secondAnchor - _controller.extent.currentExtent).abs()
          ? secondAnchor
          : firstAnchor;
    }
  }

  List<double> _findNearestAnchors(List<double> list, double x) {
    list.sort();
    final diff = {for (var d in list) d: d - x};
    final firstAnchor = diff.entries.where((me) => me.value > 0).first.key;
    final secondAnchor = diff.entries.where((me) => me.value < 0).last.key;

    return [firstAnchor, secondAnchor];
  }

  double _findNextAnchorFromPrevious(double previousAnchor, double nextAnchor) {
    const percent = 0.2;

    return (_controller.extent.currentExtent - previousAnchor).abs() >
            (nextAnchor - previousAnchor).abs() * percent
        ? nextAnchor
        : previousAnchor;
  }

  Future<void> _animateToNextAnchor(double nextAnchor) async {
    if (_controller.extent.currentExtent == nextAnchor) return;

    _topOffsetTween
      ..begin = _controller.extent.currentExtent
      ..end = nextAnchor;

    await _animationController.forward();

    if (nextAnchor <= widget.minHeight && !_isClosing) {
      _dismiss();
    }
  }

  List<double> get _screenAnchors => {
        if (widget.anchors != null) ...widget.anchors,
        widget.maxHeight,
        widget.minHeight,
        widget.initHeight,
      }.toList();

  void _dismiss() {
    if (widget.onDismiss != null) widget.onDismiss();
    Navigator.pop(context);
  }
}

// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// ignore_for_file: avoid-returning-widgets

const Duration _bottomSheetDuration = Duration(milliseconds: 500);

/// Shows a flexible bottom sheet.
///
/// [builder] - content's builder
/// [minHeight] - min height in percent for bottom sheet. e.g. 0.1
/// [initHeight] - init height in percent for bottom sheet. e.g. 0.5
/// [maxHeight] - init height in percent for bottom sheet. e.g. 0.5
/// [isModal] - if true, overlay background with dark color
/// [anchors] - percent height that bottom sheet can be
Future<T> showFlexibleBottomSheet<T>({
  @required BuildContext context,
  @required FlexibleDraggableScrollableWidgetBuilder builder,
  double minHeight,
  double initHeight,
  double maxHeight,
  bool isCollapsible = true,
  bool isExpand = true,
  bool useRootNavigator = false,
  bool isModal = true,
  List<double> anchors,
}) {
  assert(debugCheckHasMediaQuery(context));
  assert(debugCheckHasMaterialLocalizations(context));

  return Navigator.of(context, rootNavigator: useRootNavigator).push(
    _FlexibleBottomSheetRoute<T>(
      theme: Theme.of(context),
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      minHeight: minHeight ?? 0,
      initHeight: initHeight ?? 0.5,
      maxHeight: maxHeight ?? 1,
      isCollapsible: isCollapsible,
      isExpand: isExpand,
      builder: builder,
      isModal: isModal,
      anchors: anchors,
    ),
  );
}

/// Shows a flexible bottom sheet with the ability to scroll content
/// even without a list
///
/// [builder] - content's builder
/// [minHeight] - min height in percent for bottom sheet. e.g. 0.1
/// [initHeight] - init height in percent for bottom sheet. e.g. 0.5
/// [maxHeight] - init height in percent for bottom sheet. e.g. 0.5
/// [isModal] - if true, overlay background with dark color
/// [anchors] - percent height that bottom sheet can be
/// isPinnedHeader - can the header scroll
/// [decoration] - BottomSheet decoration
/// [minHeaderHeight] - minimum head size
/// [maxHeaderHeight] - maximum head size
/// [headerHeight] - head size.
/// decoratedBox - decoration for header and content
/// Sets both [minHeaderHeight] and [maxHeaderHeight]
Future<T> showStickyFlexibleBottomSheet<T>({
  @required BuildContext context,
  @required FlexibleDraggableScrollableHeaderWidgetBuilder headerBuilder,
  @required FlexibleDraggableScrollableWidgetBodyBuilder builder,
  double minHeight,
  double initHeight,
  double maxHeight,
  bool isCollapsible = true,
  bool isExpand = true,
  bool useRootNavigator = false,
  bool isModal = true,
  List<double> anchors,
  double minHeaderHeight,
  double maxHeaderHeight,
  double headerHeight,
  Decoration decoration,
}) {
  assert(maxHeaderHeight != null || headerHeight != null);
  assert(debugCheckHasMediaQuery(context));
  assert(debugCheckHasMaterialLocalizations(context));

  return Navigator.of(context, rootNavigator: useRootNavigator).push(
    _FlexibleBottomSheetRoute<T>(
      theme: Theme.of(context),
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      minHeight: minHeight ?? 0,
      initHeight: initHeight ?? 0.5,
      maxHeight: maxHeight ?? 1,
      isCollapsible: isCollapsible,
      isExpand: isExpand,
      bodyBuilder: builder,
      headerBuilder: headerBuilder,
      isModal: isModal,
      anchors: anchors,
      minHeaderHeight: minHeaderHeight ?? headerHeight ?? maxHeaderHeight / 2,
      maxHeaderHeight: maxHeaderHeight ?? headerHeight,
      decoration: decoration,
    ),
  );
}

/// A modal route with flexible bottom sheet.
class _FlexibleBottomSheetRoute<T> extends PopupRoute<T> {
  _FlexibleBottomSheetRoute({
    @required this.minHeight,
    @required this.initHeight,
    @required this.maxHeight,
    @required this.isCollapsible,
    @required this.isExpand,
    @required this.isModal,
    this.builder,
    this.headerBuilder,
    this.bodyBuilder,
    this.theme,
    this.barrierLabel,
    this.anchors,
    this.minHeaderHeight,
    this.maxHeaderHeight,
    this.decoration,
    RouteSettings settings,
  }) : super(settings: settings);

  final FlexibleDraggableScrollableWidgetBuilder builder;
  final FlexibleDraggableScrollableHeaderWidgetBuilder headerBuilder;
  final FlexibleDraggableScrollableWidgetBodyBuilder bodyBuilder;
  final double minHeight;
  final double initHeight;
  final double maxHeight;
  final bool isCollapsible;
  final bool isExpand;
  final bool isModal;
  final List<double> anchors;
  final double minHeaderHeight;
  final double maxHeaderHeight;
  final Decoration decoration;

  final ThemeData theme;

  @override
  Duration get transitionDuration => _bottomSheetDuration;

  @override
  bool get barrierDismissible => true;

  @override
  final String barrierLabel;

  @override
  Color get barrierColor => isModal ? Colors.black54 : const Color(0x00FFFFFF);

  AnimationController _animationController;

  @override
  AnimationController createAnimationController() {
    _animationController = AnimationController(
      duration: _bottomSheetDuration,
      debugLabel: 'FlexibleBottomSheet',
      vsync: navigator?.overlay as TickerProvider,
    );

    return _animationController;
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    Widget bottomSheet = MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: isCollapsible
          ? FlexibleBottomSheet.collapsible(
              initHeight: initHeight,
              maxHeight: maxHeight,
              builder: builder,
              headerBuilder: headerBuilder,
              bodyBuilder: bodyBuilder,
              isExpand: isExpand,
              animationController: _animationController,
              anchors: anchors,
              minHeaderHeight: minHeaderHeight,
              maxHeaderHeight: maxHeaderHeight,
              decoration: decoration,
            )
          : FlexibleBottomSheet(
              minHeight: minHeight,
              initHeight: initHeight,
              maxHeight: maxHeight,
              builder: builder,
              headerBuilder: headerBuilder,
              bodyBuilder: bodyBuilder,
              isExpand: isExpand,
              animationController: _animationController,
              anchors: anchors,
              minHeaderHeight: minHeaderHeight,
              maxHeaderHeight: maxHeaderHeight,
              decoration: decoration,
            ),
    );

    if (theme != null) {
      bottomSheet = Theme(data: theme, child: bottomSheet);
    }

    return bottomSheet;
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    final curve = Curves.ease;
    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: super.buildTransitions(
        context,
        animation,
        secondaryAnimation,
        child,
      ),
    );
  }
}
