import 'package:flutter/material.dart';

import '../../core/constants/api_constants.dart';

Future<void> showPaymentProofViewer(
  BuildContext context, {
  required String imageUrl,
}) {
  final resolvedUrl = resolveBackendAssetUrl(imageUrl);

  return showDialog<void>(
    context: context,
    barrierColor: Colors.black87,
    builder: (context) => Dialog.fullscreen(
      backgroundColor: Colors.black,
      child: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: InteractiveViewer(
                minScale: 0.7,
                maxScale: 4,
                child: Center(
                  child: Image.network(
                    resolvedUrl,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) {
                        return child;
                      }

                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) => Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.broken_image_outlined,
                            color: Colors.white70,
                            size: 48,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Bukti pembayaran gagal dimuat.',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          SelectableText(
                            resolvedUrl,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton.filled(
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white24,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
                tooltip: 'Tutup',
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

String resolveBackendAssetUrl(String url) {
  final uri = Uri.tryParse(url);
  if (uri == null) {
    return url;
  }

  final apiUri = Uri.parse(ApiConstants.kBaseUrl);
  if (!uri.hasScheme && url.startsWith('/')) {
    return Uri(
      scheme: apiUri.scheme,
      host: apiUri.host,
      port: apiUri.hasPort ? apiUri.port : 0,
      path: uri.path,
      query: uri.query,
      fragment: uri.fragment,
    ).toString();
  }

  if (!uri.hasScheme || uri.host.isEmpty) {
    return url;
  }

  const localHosts = {'localhost', '127.0.0.1', '10.0.2.2'};
  final isBackendAsset =
      uri.path.startsWith('/storage/') || uri.path.startsWith('/images/');
  if (!localHosts.contains(uri.host) && !isBackendAsset) {
    return url;
  }

  return Uri(
    scheme: apiUri.scheme,
    host: apiUri.host,
    port: apiUri.hasPort ? apiUri.port : 0,
    path: uri.path,
    query: uri.query,
    fragment: uri.fragment,
  ).toString();
}
