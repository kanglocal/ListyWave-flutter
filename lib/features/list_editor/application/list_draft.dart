import 'package:flutter/foundation.dart';

import '../../../core/models/comment_type.dart';
import '../../../core/models/list_type.dart';
import '../../../core/theme/colors.dart';

/// 아이템 이미지. 서버에 이미 있는 이미지([RemoteItemImage])는 URL 을 그대로 보내고,
/// 새로 고른 이미지([LocalItemImage])는 리스트 저장 뒤 presigned URL 로 올린다.
sealed class ItemImage {
  const ItemImage();
}

class RemoteItemImage extends ItemImage {
  const RemoteItemImage(this.url);

  final String url;
}

class LocalItemImage extends ItemImage {
  const LocalItemImage({required this.bytes, required this.mimeType});

  final Uint8List bytes;
  final String mimeType;
}

/// 아이템 하나 (web `ItemCreateType`). rank 는 목록 순서로 정한다.
@immutable
class DraftItem {
  const DraftItem({
    required this.title,
    this.id,
    this.comment = '',
    this.link = '',
    this.image,
  });

  /// 수정 화면에서 서버에 이미 있던 아이템 id. 새 아이템이면 null 이다.
  final int? id;
  final String title;
  final String comment;
  final String link;
  final ItemImage? image;
}

/// 리스트 생성/수정 요청 내용 (web `ListCreateType` / `ListEditType`,
/// backend `ListCreateRequest` / `ListUpdateRequest`).
@immutable
class ListDraft {
  const ListDraft({
    required this.category,
    required this.title,
    required this.items,
    this.labels = const [],
    this.collaborators = const [],
    this.description = '',
    this.isPublic = true,
    this.backgroundPalette = BackgroundPalette.pastel,
    this.backgroundColor = 'PASTEL_PINK',
  });

  /// 수정 화면의 초기값. 주인은 협업자 목록에서 뺀다 (web 은 로그인 사용자를 빼서, 협업자가
  /// 수정하면 자기 자신이 빠진다).
  factory ListDraft.fromDetail(ListDetailType detail) => ListDraft(
    category: detail.categoryEngName.toLowerCase(),
    title: detail.title,
    description: detail.description ?? '',
    labels: [for (final l in detail.labels) l.name],
    collaborators: [
      for (final c in detail.collaborators)
        if (c.id != detail.ownerId) c,
    ],
    isPublic: detail.isPublic,
    backgroundPalette: BackgroundPalette.values.firstWhere(
      (p) => p.name.toUpperCase() == detail.backgroundPalette,
      orElse: () => BackgroundPalette.pastel,
    ),
    backgroundColor: detail.backgroundColor,
    items: [
      for (final item in [...detail.items]..sort((a, b) => a.rank - b.rank))
        DraftItem(
          id: item.id,
          title: item.title,
          comment: item.comment ?? '',
          link: item.link ?? '',
          image: (item.imageUrl ?? '').isEmpty
              ? null
              : RemoteItemImage(item.imageUrl!),
        ),
    ],
  );

  /// backend `CategoryType` 영문 이름 (예: `music`).
  final String category;
  final List<String> labels;
  final List<CollaboratorType> collaborators;
  final String title;
  final String description;
  final bool isPublic;
  final BackgroundPalette backgroundPalette;

  /// backend `BackgroundColor` 이름 (예: `PASTEL_PINK`).
  final String backgroundColor;
  final List<DraftItem> items;

  /// 새로 올릴 이미지와 그 rank.
  List<({int rank, LocalItemImage image})> get localImages => [
    for (var i = 0; i < items.length; i++)
      if (items[i].image case final LocalItemImage image)
        (rank: i + 1, image: image),
  ];

  /// 요청 body. rank 는 1 부터 목록 순서다. 새 이미지 자리는 빈 문자열로 보내고 업로드가 끝나면
  /// 서버가 채운다 (web `formatData`). backend `ItemComment` 는 null 을 받지 않으므로
  /// 빈 문자열을 보낸다.
  Map<String, Object?> toJson() => {
    'category': category,
    'labels': labels,
    'collaboratorIds': [for (final c in collaborators) c.id],
    'title': title,
    'description': description,
    'isPublic': isPublic,
    'backgroundPalette': backgroundPalette.name.toUpperCase(),
    'backgroundColor': backgroundColor,
    'items': [
      for (var i = 0; i < items.length; i++)
        {
          'rank': i + 1,
          'title': items[i].title,
          'comment': items[i].comment,
          'link': items[i].link,
          'imageUrl': switch (items[i].image) {
            RemoteItemImage(:final url) => url,
            _ => '',
          },
        },
    ],
  };
}
