import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../widgets/error_view.dart';
import '../widgets/genre_filter_chip.dart';
import '../widgets/loading_shimmer.dart';
import '../widgets/movie_card.dart';
import '../widgets/search_bar_widget.dart';
import 'movie_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieProvider>().initializeData();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MovieProvider>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF9F7FF),
              Color(0xFFF2ECFF),
              Color(0xFFEEE7FF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: provider.refreshMovies,
            color: const Color(0xFF7B61FF),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF8D74FF),
                                Color(0xFF6E56F8),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF7B61FF).withOpacity(0.28),
                                blurRadius: 30,
                                offset: const Offset(0, 14),
                              ),
                            ],
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Movie App',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -0.8,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Cari film favoritmu dengan tampilan yang lebih modern, clean, dan nyaman dilihat.',
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.45,
                                  color: Color(0xFFEAE4FF),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        SearchBarWidget(
                          controller: _searchController,
                          onChanged: provider.searchMovies,
                          onClear: () {
                            _searchController.clear();
                            provider.searchMovies('');
                            setState(() {});
                          },
                        ),
                        const SizedBox(height: 18),
                        SizedBox(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              GenreFilterChip(
                                label: 'Semua',
                                isSelected: provider.selectedGenreId == null,
                                onTap: () => provider.applyGenreFilter(null),
                              ),
                              ...provider.genres.map(
                                (genre) => GenreFilterChip(
                                  label: genre.name,
                                  isSelected: provider.selectedGenreId == genre.id,
                                  onTap: () => provider.applyGenreFilter(genre.id),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (provider.errorMessage.isNotEmpty &&
                            provider.movies.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF4EA),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: const Color(0xFFFFDAB8),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.info_outline_rounded,
                                  color: Color(0xFFE48A2D),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    provider.errorMessage,
                                    style: const TextStyle(
                                      color: Color(0xFF9F6120),
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(height: 22),
                      ],
                    ),
                  ),
                ),
                if (provider.isLoading)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: LoadingShimmer(),
                  )
                else if (provider.movies.isEmpty && provider.errorMessage.isNotEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: ErrorView(
                      message: provider.errorMessage,
                      onRetry: provider.refreshMovies,
                    ),
                  )
                else if (provider.movies.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.movie_filter_outlined,
                              size: 74,
                              color: Color(0xFFC7BFE2),
                            ),
                            SizedBox(height: 14),
                            Text(
                              'Film tidak ditemukan',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF211C37),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Coba kata kunci lain atau ubah filter genre yang kamu pilih.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF766F8B),
                                height: 1.45,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                    sliver: SliverList.builder(
                      itemCount: provider.movies.length,
                      itemBuilder: (context, index) {
                        final movie = provider.movies[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: MovieCard(
                            movie: movie,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MovieDetailPage(movie: movie),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}