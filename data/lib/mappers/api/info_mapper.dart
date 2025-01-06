part of '../mappers.dart';

class InfoMapper extends Mapper<InfoEntity, domain.Info> {
  @override
  domain.Info fromEntity(InfoEntity entity) {
    return domain.Info(
      count: entity.count,
      pages: entity.pages,
      next: entity.next,
      prev: entity.prev,
    );
  }

  @override
  InfoEntity toEntity(domain.Info item) {
    return InfoEntity(
      count: item.count,
      pages: item.pages,
      next: item.next,
      prev: item.prev,
    );
  }
}
