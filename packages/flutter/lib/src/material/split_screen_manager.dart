// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// 分屏管理器 - 管理左右两侧的页面显示状态
class SplitScreenManager extends ChangeNotifier {
  /// 单例实例
  static final SplitScreenManager _instance = SplitScreenManager._internal();

  /// 存储初始主页
  Widget? _initialHome;

  /// 存储当前应该显示在右侧的widget
  Widget? _currentPage;

  /// 存储路由栈中的所有页面
  final List<Widget> _pageStack = <Widget>[];

  /// 右侧导航器的状态引用
  NavigatorState? _rightNavigator;

  /// 左侧导航器的状态引用
  NavigatorState? _leftNavigator;

  factory SplitScreenManager() {
    return _instance;
  }

  SplitScreenManager._internal();

  /// 获取初始主页
  Widget? get initialHome => _initialHome;

  /// 设置初始主页
  void setInitialHome(Widget home) {
    _initialHome = home;
    notifyListeners();
  }

  /// 设置当前右侧页面
  void setCurrentPage(Widget page) {
    _currentPage = page;
    notifyListeners();
  }

  /// 获取当前右侧页面
  Widget? get currentPage => _currentPage;

  /// 设置右侧导航器的引用
  void setRightNavigator(NavigatorState navigator) {
    _rightNavigator = navigator;
  }

  /// 获取右侧导航器
  NavigatorState? get rightNavigator {
    return _rightNavigator;
  }

  /// 设置左侧导航器的引用
  void setLeftNavigator(NavigatorState navigator) {
    _leftNavigator = navigator;
  }

  /// 获取左侧导航器
  NavigatorState? get leftNavigator {
    return _leftNavigator;
  }

  /// 转发导航到右侧导航器 - push 操作
  Future<T?> pushToRight<T extends Object?>(Route<T> route) {
    if (_rightNavigator != null) {
      if (route is MaterialPageRoute<T>) {
        final MaterialPageRoute<T> materialRoute = route;

        // 创建新的路由用于右侧导航器
        final MaterialPageRoute<T> newRoute = MaterialPageRoute<T>(
          settings: route.settings,
          builder: materialRoute.builder,
        );

        return _rightNavigator!.push(newRoute);
      } else {
        return _rightNavigator!.push(route);
      }
    } else {
      return Future.value(null);
    }
  }

  /// 转发导航到右侧导航器 - pushNamed 操作
  Future<T?> pushNamedToRight<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    if (_rightNavigator != null) {
      return _rightNavigator!.pushNamed(routeName, arguments: arguments);
    }
    return Future.value(null);
  }

  /// 转发导航到右侧导航器 - pop 操作
  void popRight<T extends Object?>([T? result]) {
    if (_rightNavigator != null) {
      _rightNavigator!.pop(result);
    }
  }

  /// 添加页面到栈中
  void pushPage(Widget page) {
    _pageStack.add(page);
    _currentPage = page;
    notifyListeners();
  }

  /// 从栈中移除页面
  void popPage() {
    if (_pageStack.isNotEmpty) {
      _pageStack.removeLast();
      if (_pageStack.isNotEmpty) {
        _currentPage = _pageStack.last;
      } else {
        _currentPage = _initialHome;
      }
      notifyListeners();
    }
  }

  /// 重置状态
  void reset() {
    _initialHome = null;
    _currentPage = null;
    _pageStack.clear();
    notifyListeners();
  }
}
