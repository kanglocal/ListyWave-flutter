import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/requested_topic_type.dart';
import '../../../core/pagination/cursor_page.dart';
import '../../../core/pagination/paginated_notifier.dart';
import '../data/topics_api.dart';

/// web QUERY_KEYS.getTopics (infinite, `cursorId`).
class TopicsNotifier extends PaginatedNotifier<RequestedTopicType, int> {
  @override
  Future<CursorPage<RequestedTopicType, int>> fetchPage(int? cursor) async {
    final response = await ref
        .read(topicsApiProvider)
        .getTopics(cursorId: cursor);
    return CursorPage(
      items: response.topics,
      nextCursor: response.hasNext ? response.cursorId : null,
      hasNext: response.hasNext,
    );
  }
}

final topicsProvider =
    AsyncNotifierProvider.autoDispose<
      TopicsNotifier,
      PageState<RequestedTopicType, int>
    >(TopicsNotifier.new);
