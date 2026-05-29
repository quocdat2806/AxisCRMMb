part of 'advance_cubit.dart';

enum AdvanceStatus { pending, approved, rejected }

class AdvanceRequest extends Equatable {
  const AdvanceRequest({
    required this.id,
    required this.date,
    required this.amount,
    required this.reason,
    required this.status,
  });

  final String id;
  final DateTime date;
  final int amount;
  final String reason;
  final AdvanceStatus status;

  @override
  List<Object> get props => <Object>[id, date, amount, reason, status];
}

class AdvanceState extends Equatable {
  const AdvanceState({
    required this.advanceMonth,
    required this.advances,
    required this.advanceAmount,
    required this.advanceReason,
    required this.advanceDate,
  });

  final DateTime advanceMonth;
  final List<AdvanceRequest> advances;
  final String advanceAmount;
  final String advanceReason;
  final DateTime advanceDate;

  factory AdvanceState.initial() {
    final DateTime now = DateTime.now();
    return AdvanceState(
      advanceMonth: DateTime(now.year, now.month),
      advances: <AdvanceRequest>[
        AdvanceRequest(
          id: '1',
          date: DateTime(now.year, now.month, 5),
          amount: 1000000,
          reason: 'Chi phí sinh hoạt',
          status: AdvanceStatus.approved,
        ),
        AdvanceRequest(
          id: '2',
          date: DateTime(now.year, now.month, 16),
          amount: 500000,
          reason: 'Ứng trước',
          status: AdvanceStatus.pending,
        ),
      ],
      advanceAmount: '',
      advanceReason: '',
      advanceDate: now,
    );
  }

  List<AdvanceRequest> get filteredAdvances {
    return advances.where((AdvanceRequest item) {
      return item.date.year == advanceMonth.year &&
          item.date.month == advanceMonth.month;
    }).toList();
  }

  int get monthlyAdvanceTotal {
    return filteredAdvances.fold<int>(
      0,
      (int total, AdvanceRequest item) => total + item.amount,
    );
  }

  AdvanceState copyWith({
    DateTime? advanceMonth,
    List<AdvanceRequest>? advances,
    String? advanceAmount,
    String? advanceReason,
    DateTime? advanceDate,
  }) {
    return AdvanceState(
      advanceMonth: advanceMonth ?? this.advanceMonth,
      advances: advances ?? this.advances,
      advanceAmount: advanceAmount ?? this.advanceAmount,
      advanceReason: advanceReason ?? this.advanceReason,
      advanceDate: advanceDate ?? this.advanceDate,
    );
  }

  @override
  List<Object> get props => <Object>[
    advanceMonth,
    advances,
    advanceAmount,
    advanceReason,
    advanceDate,
  ];
}