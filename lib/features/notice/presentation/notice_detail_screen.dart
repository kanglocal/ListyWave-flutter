import 'package:flutter/material.dart';

import '../../../core/widgets/placeholder_screen.dart';

class NoticeDetailScreen extends StatelessWidget {
  const NoticeDetailScreen({super.key, required this.noticeId});

  final String noticeId;

  @override
  Widget build(BuildContext context) => PlaceholderScreen(
    title: 'NoticeDetailScreen',
    params: {'noticeId': noticeId},
  );
}
