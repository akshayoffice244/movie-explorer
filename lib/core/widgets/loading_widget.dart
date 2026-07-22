import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_explorer/core/widgets/movie_tile_widget.dart';
import 'package:shimmer/shimmer.dart';


class LoadingWidget extends StatelessWidget {
  final Axis scrollDirection;
  const LoadingWidget({super.key,
    required this.scrollDirection
  });

  @override
  Widget build(BuildContext context) {
      if(scrollDirection == Axis.vertical){
        return  Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Shimmer.fromColors(
                enabled: true,
                baseColor: Colors.grey.shade400,
                highlightColor: Colors.white,
                child: Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(12),
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: SizedBox(
                        height: 150,
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 18,
                              width: double.infinity,
                              color: Colors.white,
                            ),

                            const SizedBox(height: 10),

                            Container(
                              height: 18,
                              width: 120,
                              color: Colors.white,
                            ),

                            const SizedBox(height: 12),

                            Container(
                              height: 14,
                              width: 80,
                              color: Colors.white,
                            ),

                            const SizedBox(height: 16),

                            Container(
                              height: 12,
                              width: double.infinity,
                              color: Colors.white,
                            ),

                            const SizedBox(height: 8),

                            Container(
                              height: 12,
                              width: double.infinity,
                              color: Colors.white,
                            ),

                            const SizedBox(height: 8),

                            Container(
                              height: 12,
                              width: 180,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }

      return Container(
        width: 160,
        margin: const EdgeInsets.only(right: 12),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Shimmer.fromColors(
            enabled: true,
            baseColor: Colors.grey.shade400,
            highlightColor: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                        ),
                        child: const Icon(
                          Icons.movie_outlined,
                          size: 60,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          height: 15,

                          color: Colors.grey.shade100,

                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        child: Container(
                          height: 15,
                          width: 100,
                          color: Colors.grey.shade100,

                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }
}
