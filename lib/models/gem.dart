class Gem {
  final String gemName;
  final String gemCode;
  final String gemVariety;
  final String gemHolder;
  final String previousOwner;

  final double roughWeight;
  final double weightAfterPerform;
  final double weightAfterCutAndPolish;

  final double widthAfterCutPolish;
  final double heightAfterCutPolish;

  final double purchasedPrice;
  final DateTime purchasedDate;
  final double performingCharges;
  final double cuttingCharges;
  final double totalCost;

  final String? gemImage; // optional image path or URL

  Gem({
    required this.gemName,
    required this.gemCode,
    required this.gemVariety,
    required this.gemHolder,
    required this.previousOwner,
    required this.roughWeight,
    required this.weightAfterPerform,
    required this.weightAfterCutAndPolish,
    required this.widthAfterCutPolish,
    required this.heightAfterCutPolish,
    required this.purchasedPrice,
    required this.purchasedDate,
    required this.performingCharges,
    required this.cuttingCharges,
    required this.totalCost,
    this.gemImage,
  });
}
