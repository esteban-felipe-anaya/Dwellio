import 'package:freezed_annotation/freezed_annotation.dart';

part 'agent.freezed.dart';
part 'agent.g.dart';

/// A real-estate agent attached to listings.
@freezed
abstract class Agent with _$Agent {
  const factory Agent({
    required String id,
    required String name,
    String? photo,
    @Default('') String agency,
    @Default('') String phone,
    @Default(0) num rating,
    @Default(0) int reviewCount,
  }) = _Agent;

  factory Agent.fromJson(Map<String, dynamic> json) => _$AgentFromJson(json);
}
