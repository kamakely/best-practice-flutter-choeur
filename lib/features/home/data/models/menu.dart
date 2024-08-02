class Menu {
  const Menu({
    required this.name,
    this.onTap,
  });

  final String name;
  final void Function()? onTap;
}
