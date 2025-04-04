import 'package:shadcn_flutter/shadcn_flutter.dart';

class AlertDialog extends StatefulWidget {
  final Widget? leading;
  final Widget? trailing;
  final Widget? title;
  final Widget? content;
  final List<Widget>? actions;
  final double? surfaceBlur;
  final double? surfaceOpacity;
  final Color? barrierColor;
  final EdgeInsetsGeometry? padding;
  final bool? actionsCenterAlign;

  const AlertDialog({
    super.key,
    this.leading,
    this.title,
    this.content,
    this.actions,
    this.trailing,
    this.surfaceBlur,
    this.surfaceOpacity,
    this.barrierColor,
    this.padding,
    this.actionsCenterAlign,
  });

  @override
  _AlertDialogState createState() => _AlertDialogState();
}

class _AlertDialogState extends State<AlertDialog> {
  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var scaling = themeData.scaling;
    return ModalContainer(
      borderRadius: themeData.borderRadiusXxl,
      barrierColor: widget.barrierColor ?? Colors.black.withValues(alpha: 0.8),
      surfaceClip: ModalContainer.shouldClipSurface(
          widget.surfaceOpacity ?? themeData.surfaceOpacity),
      child: OutlinedContainer(
        backgroundColor: themeData.colorScheme.popover,
        borderRadius: themeData.borderRadiusXxl,
        borderWidth: 1 * scaling,
        borderColor: themeData.colorScheme.muted,
        padding: widget.padding ?? EdgeInsets.all(24 * scaling),
        surfaceBlur: widget.surfaceBlur ?? themeData.surfaceBlur,
        surfaceOpacity: widget.surfaceOpacity ?? themeData.surfaceOpacity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.leading != null)
                    widget.leading!.iconXLarge().iconMutedForeground(),
                  if (widget.title != null || widget.content != null)
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.title != null)
                            widget.title!.large().semiBold(),
                          if (widget.content != null)
                            widget.content!.small().muted(),
                        ],
                      ).gap(8 * scaling),
                    ),
                  if (widget.trailing != null)
                    widget.trailing!.iconXLarge().iconMutedForeground(),
                ],
              ).gap(16 * scaling),
            ),
            if (widget.actions != null && widget.actions!.isNotEmpty)
              Row(
                mainAxisAlignment: widget.actionsCenterAlign == null ? MainAxisAlignment.end : MainAxisAlignment.center,
                // mainAxisSize: widget.actionsCenterAlign == null ? MainAxisSize.min : MainAxisSize.max,
                // mainAxisSize: MainAxisSize.max,
                // children: widget.actions!,
                children: join(widget.actions!, SizedBox(width: 8 * scaling))
                    .toList(),
              ),
          ],
        ).gap(16 * scaling),
      ),
    );
  }
}
