part of 'project_detail_cubit.dart';

class ProjectDetailState extends Equatable {
  const ProjectDetailState({
    this.project,
    this.advances = const [],
    this.isLoading = false,
    this.error,
  });

  final Project? project;
  final List<ProjectAdvanceItem> advances;
  final bool isLoading;
  final String? error;

  ProjectDetailState copyWith({
    Project? project,
    List<ProjectAdvanceItem>? advances,
    bool? isLoading,
    String? error,
  }) {
    return ProjectDetailState(
      project: project ?? this.project,
      advances: advances ?? this.advances,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [project, advances, isLoading, error];
}
