import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class AnimatedFilterDropdown extends StatefulWidget {
  final List<String> items;
  final String? initialValue;
  final String? hintText;
  final Function(String?) onSelected;

  const AnimatedFilterDropdown({
    super.key,
    required this.items,
    this.initialValue,
    this.hintText,
    required this.onSelected,
  });

  @override
  State<AnimatedFilterDropdown> createState() => _AnimatedFilterDropdownState();
}

class _AnimatedFilterDropdownState extends State<AnimatedFilterDropdown>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  String? _selectedValue;
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  final Duration _animationDuration = const Duration(milliseconds: 800);

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
    _animationController =
        AnimationController(duration: _animationDuration, vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(covariant AnimatedFilterDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _animationController.dispose();
    super.dispose();
  }

  void toggleDropdown() {
    if (_isExpanded) {
      _animationController.reverse().then((_) {
        _overlayEntry?.remove();
        _overlayEntry = null;
      });
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
      _animationController.forward();
    }
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (_) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height + 8,
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 8),
          child: AnimatedBuilder(
            animation: _animation,
            builder: (_, child) {
              return ClipRect(
                child: Align(
                  heightFactor: _animation.value,
                  alignment: Alignment.topCenter,
                  child: Material(
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(
                      AppBorderRadius.borderRadius12,
                    ),
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: widget.items.length,
                        itemBuilder: (_, int index) {
                          final bool isSelected =
                              widget.items[index] == _selectedValue;
                          return ListTile(
                            title: Text(widget.items[index] ?? ''),
                            onTap: () {
                              if (widget.items[index] != _selectedValue) {
                                setState(() {
                                  _selectedValue = widget.items[index];
                                });
                                widget.onSelected(widget.items[index]);
                              }
                              toggleDropdown();
                            },
                            tileColor: isSelected ? AppColors.lightGrey : null,
                          );
                        }),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: () => toggleDropdown(),
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: mediaQueryData.size.width / 3),
          child: IntrinsicWidth(
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(AppBorderRadius.borderRadius12),
                border: Border.all(
                  color: AppColors.green,
                  width: 1.0,
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.padding16,
                vertical: AppPadding.padding10,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    _selectedValue ?? widget.hintText ?? 'Select',
                    style: AppTextTheme.font17,
                  ),
                  //const SizedBox(width: 4.0),
                  Icon(
                    _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
