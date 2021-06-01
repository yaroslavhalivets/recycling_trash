enum TrashCanStatuses { work, full, broken }

extension TrashCanStatusesExtension on TrashCanStatuses {
  String get name {
    switch (this) {
      case TrashCanStatuses.work:
        return 'work';
      case TrashCanStatuses.full:
        return 'full';
      case TrashCanStatuses.broken:
        return 'broken';
    }
  }
}
