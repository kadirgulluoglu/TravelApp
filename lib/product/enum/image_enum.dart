enum AssetsEnum {
  button("button"),
  network("network"),
  balloning("balloning");

  String toPng() => 'assets/images/$name.png';
  String toJpg() => 'assets/images/$name.jpg';
  String toLottie() => 'assets/lottie/$name.json';

  final String name;
  const AssetsEnum(this.name);
}
