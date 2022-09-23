enum AssetsEnum {
  button("button"),
  balloning("balloning");

  String toPng() => 'assets/images/$name.png';
  String toJpg() => 'assets/images/$name.jpg';
  String toLottie() => 'assets/lottie/$name.lottie';

  final String name;
  const AssetsEnum(this.name);
}
