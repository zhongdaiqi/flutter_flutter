// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'split_screen_manager.dart';

/// 分屏容器 - 显示左右两侧的页面
class SplitScreenContainer extends StatefulWidget {
  /// 左侧要显示的页面
  final Widget? leftChild;

  /// 右侧要显示的页面
  final Widget? rightChild;

  /// 应用的初始路由（当 leftChild 为 null 时使用）
  final String? initialRoute;

  /// 应用的路由生成函数（当 leftChild 为 null 时使用）
  final RouteFactory? onGenerateRoute;

  /// 分割线宽度
  final double dividerWidth;

  /// 分割线颜色
  final Color dividerColor;

  /// 是否启用左侧面板
  final bool enableLeftPanel;

  /// 创建分屏容器
  const SplitScreenContainer({
    Key? key,
    this.leftChild,
    this.rightChild,
    this.initialRoute,
    this.onGenerateRoute,
    this.dividerWidth = 1.0,
    this.dividerColor = const Color(0xFFCCCCCC),
    this.enableLeftPanel = true,
  }) : super(key: key);

  @override
  State<SplitScreenContainer> createState() => _SplitScreenContainerState();
}

class _SplitScreenContainerState extends State<SplitScreenContainer>
    with WidgetsBindingObserver {
  late double _leftRatio;
  late SplitScreenManager _manager;

  @override
  void initState() {
    super.initState();
    // 注册为 WidgetsBindingObserver，以便拦截系统返回事件
    WidgetsBinding.instance.addObserver(this);
    // 初始化左侧分割比例为 0.5（50%）
    _leftRatio = 0.5;
    _manager = SplitScreenManager();
    _manager.addListener(_onManagerChanged);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _manager.removeListener(_onManagerChanged);
    super.dispose();
  }

  /// 系统返回事件处理 - 优先处理右侧 Navigator
  @override
  Future<bool> didPopRoute() async {
    // 优先尝试让右侧 Navigator 处理返回
    final rightNavigator = _manager.rightNavigator;
    if (rightNavigator != null) {
      if (rightNavigator.canPop()) {
        rightNavigator.pop();
        return true; // 返回 true 表示已处理，系统不会继续传递给其他 observer
      }
    }

    // 如果右侧无法处理，尝试让左侧 Navigator 处理返回
    final leftNavigator = _manager.leftNavigator;
    if (leftNavigator != null) {
      if (leftNavigator.canPop()) {
        leftNavigator.pop();
        return true;
      }
    }
    return false; // 返回 false 表示未处理，系统继续传递给下一个 observer
  }

  void _onManagerChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Widget leftChild = widget.leftChild ?? const SizedBox.shrink();
    final Widget rightChild = widget.rightChild ?? const SizedBox.shrink();

    return Row(
      children: <Widget>[
        // 左侧页面 - 包含 Navigator 和用户界面
        Expanded(
          flex: widget.enableLeftPanel
              ? (_leftRatio * 100).toInt().clamp(20, 80)
              : 0,
          child: Visibility(
            visible: widget.enableLeftPanel,
            child: _ProxyNavigator(
              child: leftChild,
              initialRoute: widget.initialRoute,
              onGenerateRoute: widget.onGenerateRoute,
            ),
          ),
        ),
        // 分割线 - 使用 Listener 和 GestureDetector 结合以提高灵敏度
        MouseRegion(
          cursor: SystemMouseCursors.resizeColumn,
          child: GestureDetector(
            onHorizontalDragStart: (_) {
              // 拖动开始时的回调，确保立即响应
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                final RenderBox renderBox =
                    context.findRenderObject() as RenderBox;
                final double width = renderBox.size.width;
                _leftRatio = (_leftRatio * width + details.delta.dx) / width;
                // 限制比例在 20% - 80% 之间
                if (_leftRatio < 0.2) {
                  _leftRatio = 0.2;
                } else if (_leftRatio > 0.8) {
                  _leftRatio = 0.8;
                }
              });
            },
            // 增加触摸响应的敏感度
            behavior: HitTestBehavior.translucent,
            child: Container(
              width: widget.dividerWidth,
              color: widget.dividerColor,
            ),
          ),
        ),
        // 右侧页面 - 包含 Navigator 和用户界面
        Expanded(
          flex: ((1 - _leftRatio) * 100).toInt().clamp(20, 80),
          child: Container(
            color: Colors.white,
            child: _RightSideNavigator(
              child: rightChild,
              initialRoute: widget.initialRoute,
              onGenerateRoute: widget.onGenerateRoute,
            ),
          ),
        ),
      ],
    );
  }
}

/// 代理导航器 - 将左侧的导航操作转发到右侧的真实导航器
class _ProxyNavigator extends StatefulWidget {
  final Widget child;
  final String? initialRoute;
  final RouteFactory? onGenerateRoute;

  const _ProxyNavigator({
    GlobalKey<_ProxyNavigatorState>? key,
    required this.child,
    this.initialRoute,
    this.onGenerateRoute,
  }) : super(key: key);

  @override
  State<_ProxyNavigator> createState() => _ProxyNavigatorState();
}

class _ProxyNavigatorState extends State<_ProxyNavigator> {
  late SplitScreenManager _manager;
  late _ProxyNavigatorObserver _observer;
  late GlobalKey<NavigatorState> _navigatorKey;

  /// 用于追踪这个State实例的唯一ID
  static int _instanceCounter = 0;
  late int _instanceId;

  @override
  void initState() {
    super.initState();
    _instanceId = ++_instanceCounter;
    _manager = SplitScreenManager();
    _observer = _ProxyNavigatorObserver(_manager);
    _navigatorKey = GlobalKey<NavigatorState>();
  }

  @override
  Widget build(BuildContext context) {
    // 设置左侧导航器的引用
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_navigatorKey.currentState != null) {
        _manager.setLeftNavigator(_navigatorKey.currentState!);
      }
    });

    return Navigator(
      key: _navigatorKey,
      initialRoute: widget.initialRoute ?? '/',
      observers: <NavigatorObserver>[
        _observer,
      ],
      onGenerateRoute: (RouteSettings settings) {
        // 如果是根路由
        if (settings.name == '/' || settings.name == null) {
          // 如果有 leftChild，直接显示它
          if (widget.child is! SizedBox) {
            return MaterialPageRoute<dynamic>(
              settings: const RouteSettings(name: '/'),
              builder: (BuildContext context) => widget.child,
            );
          }

          // 如果没有 leftChild（SizedBox.shrink），尝试使用应用的 onGenerateRoute
          if (widget.onGenerateRoute != null) {
            final Route<dynamic>? route = widget.onGenerateRoute!(settings);
            if (route != null) {
              return route;
            }
          }

          // 如果都没有，返回空的占位符
          return MaterialPageRoute<dynamic>(
            settings: const RouteSettings(name: '/'),
            builder: (BuildContext context) => widget.child,
          );
        }

        // 对于非根路由，尝试使用应用的 onGenerateRoute
        if (widget.onGenerateRoute != null) {
          final Route<dynamic>? route = widget.onGenerateRoute!(settings);
          if (route != null) {
            return route;
          }
        }

        // 如果应用的 onGenerateRoute 没有处理，返回占位符路由
        // 实际的路由转发由 NavigatorObserver.didPush 处理
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => widget.child,
        );
      },
      onUnknownRoute: (RouteSettings settings) {
        // 未知路由也尝试使用应用的 onGenerateRoute
        if (widget.onGenerateRoute != null) {
          final Route<dynamic>? route = widget.onGenerateRoute!(settings);
          if (route != null) {
            return route;
          }
        }

        // 最后才返回初始内容
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: '/'),
          builder: (BuildContext context) => widget.child,
        );
      },
    );
  }
}

/// 代理导航观察器 - 监听左侧导航器的事件并转发到右侧
class _ProxyNavigatorObserver extends NavigatorObserver {
  final SplitScreenManager manager;

  _ProxyNavigatorObserver(this.manager);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // 对于任何类型的 push（包括直接 push，不仅是 pushNamed）
    // 如果 previousRoute 不为 null，说明这是在已有路由基础上的 push，需要转发给右侧
    if (previousRoute != null) {
      // 判断是否为 PopupRoute（dialog/overlay）
      final bool isPopupRoute = route is PopupRoute;

      if (!isPopupRoute) {
        // 这是真正的页面路由（如 MaterialPageRoute），需要转发到右侧
        if (manager.rightNavigator != null) {
          if (route is MaterialPageRoute<dynamic>) {
            manager.pushToRight(route as MaterialPageRoute<dynamic>);
          } else {
            manager.pushToRight(route);
          }
        }

        // 立即从左侧弹出，返回到根路由
        Future.microtask(() {
          if (manager.leftNavigator != null &&
              manager.leftNavigator!.canPop()) {
            manager.leftNavigator!.popUntil((Route<dynamic> route) {
              return route.isFirst;
            });
          }
        });
      }
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // 拦截 pop 操作，防止侧滑返回时影响应用整体
    // 左侧应该保持根路由不动，所有的返回操作不转发到右侧
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    // 当左侧有 replace 请求时，转发到右侧
    if (manager.rightNavigator != null && newRoute?.settings.name != null) {
      manager.pushNamedToRight(newRoute!.settings.name!);
    }
  }
}

/// 右侧导航器包装器 - 创建真实的Navigator并捕获其引用
class _RightSideNavigator extends StatefulWidget {
  final Widget child;
  final String? initialRoute;
  final RouteFactory? onGenerateRoute;

  const _RightSideNavigator({
    GlobalKey<_RightSideNavigatorState>? key,
    required this.child,
    this.initialRoute,
    this.onGenerateRoute,
  }) : super(key: key);

  @override
  State<_RightSideNavigator> createState() => _RightSideNavigatorState();
}

class _RightSideNavigatorState extends State<_RightSideNavigator> {
  late GlobalKey<NavigatorState> _navigatorKey;
  late SplitScreenManager _manager;

  @override
  void initState() {
    super.initState();
    _navigatorKey = GlobalKey<NavigatorState>();
    _manager = SplitScreenManager(); // 保存实例引用
  }

  @override
  Widget build(BuildContext context) {
    // 立即在build中尝试设置 Navigator引用，确保引用始终有效
    if (_navigatorKey.currentState != null) {
      _manager.setRightNavigator(_navigatorKey.currentState!);
    }

    // 使用 HeroControllerScope.none 防止多个 Navigator 共享 HeroController
    // 这样外层 Navigator 和内层应用的 Navigator 就不会产生 Hero 动画冲突
    return HeroControllerScope.none(
      child: Navigator(
        key: _navigatorKey,
        initialRoute: widget.initialRoute, // 这可能是 null 或者 "/"
        observers: <NavigatorObserver>[
          _RightSideNavigatorObserver(),
        ],
        onGenerateRoute: (RouteSettings settings) {
          // 在route生成时也确保引用有效
          if (_navigatorKey.currentState != null) {
            _manager.setRightNavigator(_navigatorKey.currentState!);
          }

          // 检查 window.defaultRouteName
          // 如果是 "/" 说明是主应用初始状态，显示空白
          // 如果不是 "/" 说明是新引擎打开了特定页面，显示内容
          final String defaultRouteName =
              WidgetsBinding.instance.window.defaultRouteName;
          if (defaultRouteName == '/') {
            // 主应用初始状态，显示起始页
            return MaterialPageRoute<dynamic>(
              settings: settings,
              builder: (BuildContext context) => const Center(
                child: Text(
                  '分屏起始页',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            );
          }

          // 新引擎或其他路由，直接返回 widget.child，让其内部的 Navigator 处理路由
          return MaterialPageRoute<dynamic>(
            settings: settings,
            builder: (BuildContext context) => widget.child,
          );
        },
        onUnknownRoute: (RouteSettings settings) {
          final String defaultRouteName =
              WidgetsBinding.instance.window.defaultRouteName;
          if (defaultRouteName == '/') {
            return MaterialPageRoute<dynamic>(
              settings: const RouteSettings(name: '/'),
              builder: (BuildContext context) => const SizedBox.expand(),
            );
          }
          return MaterialPageRoute<dynamic>(
            settings: const RouteSettings(name: '/'),
            builder: (BuildContext context) => widget.child,
          );
        },
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 在依赖项改变时（包括首次构建后），尝试设置 Navigator
    if (_navigatorKey.currentState != null) {
      _manager.setRightNavigator(_navigatorKey.currentState!); // 使用保存的实例
    } else {
      // 在下一帧再试一次
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_navigatorKey.currentState != null && mounted) {
          _manager.setRightNavigator(_navigatorKey.currentState!); // 使用保存的实例
        }
      });
    }
  }
}

/// 右侧导航观察器 - 监听右侧 Navigator 的事件
class _RightSideNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {}

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {}

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {}
}
