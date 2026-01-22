import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:news_app/models/news_response_model.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {
  final Article article = Get.arguments;
  DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: article.urlToImage != null
                  ? CachedNetworkImage(
                      imageUrl: article.urlToImage!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return Container(
                          height: 200,
                          color: AppColors.divider,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      },
                      errorWidget: (context, url, error) => SizedBox(
                        height: 200,
                        child: Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: AppColors.textHint,
                            size: 36,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 200,
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: AppColors.textHint,
                          size: 36,
                        ),
                      ),
                    ),
            ),
            actions: [
              IconButton(icon: Icon(Icons.share), onPressed: _shareArticle),
              PopupMenuButton(
                onSelected: (value) {
                  switch (value) {
                    case 'copy_link':
                      _copyLink();
                      break;
                    case 'open_in_browser':
                      _openInBrowser();
                      break;
                    default:
                  }
                },
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 'copy_link',
                      child: Row(
                        children: [
                          Icon(Icons.copy, color: Colors.black),
                          SizedBox(width: 8),
                          Text('Copy Link'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'open_in_browser',
                      child: Row(
                        children: [
                          Icon(Icons.open_in_browser, color: Colors.black),
                          SizedBox(width: 8),
                          Text('Open in Browser'),
                        ],
                      ),
                    ),
                  ];
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          article.source?.name ?? 'Unknown Source',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        timeago.format(article.publishedAt!),
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    article.title ?? 'No Title Available',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  // Description
                  Text(
                    article.description ?? 'No Description Available',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Content',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    article.content ?? 'No Content Available',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _openInBrowser,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        'Read Full Article',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),

                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _shareArticle() async {
    final rawUrl = article.url;

    if (rawUrl == null || rawUrl.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Invalid Article URL.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    final Uri url = Uri.parse(rawUrl);

    await SharePlus.instance.share(
      ShareParams(uri: url, subject: article.title?.trim()),
    );
  }

  void _copyLink() async {
    if (article.url != null) {
      Clipboard.setData(ClipboardData(text: article.url ?? 'link tidak valid'));
      Get.snackbar(
        'Success',
        'Article link copied to clipboard.',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
    }
  }

  Future<void> _openInBrowser() async {
    final rawUrl = article.url;

    if (rawUrl == null || rawUrl.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Invalid Article URL.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final Uri url = Uri.parse(rawUrl);

    final success = await launchUrl(url, mode: LaunchMode.externalApplication);

    if (!success) {
      Get.snackbar(
        'Error',
        'Could not launch the article URL.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
