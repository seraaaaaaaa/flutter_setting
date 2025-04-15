enum FontSize {
  extrasmall('Extra Small', 0.5),
  small('Small', 0.85),
  medium('Medium', 1.0),
  large('Large', 1.25),
  extralarge('Extra Large', 1.5);

  final String label;
  final double scale;

  const FontSize(this.label, this.scale);
}

int optionToIndex(FontSize option) => FontSize.values.indexOf(option);

FontSize indexToOption(double index) => FontSize.values[index.round()];
