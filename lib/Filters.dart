
class Filters {
  final String location;
  final double price;
  final double time;
  final Map<String, bool> outdoorFacility;
  final Map<String, bool> indoorFacility;

  const Filters(this.location, this.price, this.time, this.outdoorFacility, this.indoorFacility);
}