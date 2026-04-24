import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Shimmer.fromColors(
            baseColor: const Color(0xFFEAE6F3),
            highlightColor: const Color(0xFFF8F6FC),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 145,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: SizedBox(
                      height: 145,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 18,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 18,
                            width: 160,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Container(
                                height: 28,
                                width: 72,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                height: 28,
                                width: 110,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            height: 14,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 14,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 14,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}