import 'package:flutter/material.dart';

import 'list_editor_form.dart';

/// `/list/create?title=&category=` (web 프리필 query 그대로).
class ListCreateScreen extends StatelessWidget {
  const ListCreateScreen({super.key, this.title, this.category});

  final String? title;

  /// 카테고리 한글 이름 (web topics, 상세 "이 주제로 만들기") 또는 영문 이름.
  final String? category;

  @override
  Widget build(BuildContext context) =>
      ListEditorForm(prefillTitle: title, prefillCategory: category);
}
