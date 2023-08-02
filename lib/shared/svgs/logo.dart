part of 'svgs.dart';

class Logo extends _SVG {
  const Logo({super.key, super.height, super.width});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary.toHex();

    return SizedBox(
      width: width ?? 186,
      height: height ?? 182,
      child: SvgPicture.string(
        '''
<svg width="186" height="182" viewBox="0 0 186 182" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M33.2 0h13v74.4h-13V0Zm91.4 24.4h13.8V182h-13.8V24.4ZM2.6 67.8h76.2v14H2.6v-14ZM85 40h93.4v12.4H85V40Zm-7.2 100.2h108v13.2h-108v-13.2ZM81 5h101.6v30.6h-13.4V16.8H93.8v18.8H81V5ZM39 145.8c10.4-3.8 25.2-10 40.2-16.2l2.6 12c-13.2 6.2-26.6 12.6-38.4 18L39 145.8ZM19 75.4h13c-.6 47.4-3.4 84.6-21.6 106.4-2.2-3.2-6.4-7.8-9.8-10 16.2-19.4 17.8-53 18.4-96.4ZM4.4 14.8 15 12.2C20.6 27 25 46 26 58.8l-11.4 2.6c-.8-12.6-5-31.8-10.2-46.6Zm60.4-3.2L77.4 15c-4.8 15.6-11 34.6-16.2 46.6l-10-3.2C56 46 61.8 25.6 64.8 11.6ZM100 101v14.4h64V101h-64Zm0-24.2V91h64V76.8h-64ZM87.6 66.6H177v59H87.6v-59ZM46.4 74h13.2v71.8l-13.2 4.8V74Z" fill="$color"/>
</svg>
        ''',
        width: 186,
        height: 182,
      ),
    );
  }
}
