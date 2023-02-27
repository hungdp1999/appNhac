class InappModel {
  final String ?id;
  final String ?price;
  final String ?timer;

  InappModel({
    this.id,
    this.price,
    this.timer,
  });
}

List<InappModel> get testInapp => [
      InappModel(id: 'vn.famtech.3months', price: '35.000đ', timer: '3 MONTHS'),
      InappModel(id: 'vn.famtech.yearly', price: '69.000đ', timer: '1 YEAR'),
      InappModel(
          id: 'vn.famtech.lifetime', price: '109.000đ', timer: 'LIFE TIME'),
    ];
