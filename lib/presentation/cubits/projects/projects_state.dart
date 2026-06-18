part of 'projects_cubit.dart';

class ProjectsState extends Equatable {
  const ProjectsState({
    this.projects = const <Project>[],
    this.isLoading = false,
    this.error,
  });

  final List<Project> projects;
  final bool isLoading;
  final String? error;

  ProjectsState copyWith({
    List<Project>? projects,
    bool? isLoading,
    String? error,
  }) {
    return ProjectsState(
      projects: projects ?? this.projects,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => <Object?>[projects, isLoading, error];
}