import 'package:app/features/find_someone/find_someone.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hancod_theme/hancod_theme.dart';

class FindSomeoneScreen extends ConsumerWidget {
  const FindSomeoneScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final people = ref.watch(findSomeoneNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.findSomeoneTitle,
                style: AppText.heading4.copyWith(color: WhereRuBrand.navy),
              ),
              const SizedBox(height: 6),
              Text(
                context.l10n.findSomeoneSubtitle,
                style: AppText.mediumN.copyWith(color: AppColors.stormyBlue),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) =>
                    ref.read(findSomeoneQueryProvider.notifier).state = value,
                decoration: InputDecoration(
                  hintText: context.l10n.searchPeopleHint,
                  prefixIcon: const Icon(Icons.search_rounded),
                  filled: true,
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              people.when(
                loading: () => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (_, __) =>
                    _EmptyState(message: context.l10n.somethingWentWrong),
                data: (results) => results.isEmpty
                    ? _EmptyState(message: context.l10n.noPeopleNearby)
                    : Column(
                        children: [
                          for (final person in results)
                            _PersonCard(person: person),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PersonCard extends StatelessWidget {
  const _PersonCard({required this.person});

  final NearbyPerson person;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: WhereRuBrand.cardDecoration(),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: WhereRuBrand.pastelFor(person.name),
            child: Text(
              WhereRuBrand.initialsOf(person.name),
              style: AppText.mediumB.copyWith(color: WhereRuBrand.purple),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  person.name,
                  style: AppText.largeSB.copyWith(color: WhereRuBrand.navy),
                ),
                const SizedBox(height: 2),
                Text(
                  person.headline,
                  style: AppText.smallN.copyWith(color: AppColors.stormyBlue),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.near_me_outlined,
                      size: 14,
                      color: WhereRuBrand.blue,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      context.l10n.kmAway(person.distanceKm),
                      style: AppText.xSmallN.copyWith(
                        color: AppColors.stormyBlue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: context.l10n.findSomeoneTitle,
            onPressed: () =>
                context.showSnackBar(context.l10n.backendNotConnected),
            icon: const Icon(
              Icons.person_add_alt_1_rounded,
              color: WhereRuBrand.purple,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: WhereRuBrand.cardDecoration(),
      child: Column(
        children: [
          const Icon(
            Icons.person_search_rounded,
            size: 40,
            color: WhereRuBrand.purple,
          ),
          const SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppText.mediumN.copyWith(color: AppColors.stormyBlue),
          ),
        ],
      ),
    );
  }
}
