// ignore_for_file: camel_case_types

class jobLocations {
  final String name;
  final int id;

  jobLocations({required this.name, required this.id});
}

final List<jobLocations> location = [
  jobLocations(
    name: 'Brownsville',
    id: 1,
  ),
  jobLocations(
    name: 'Edinburg',
    id: 2,
  ),
  jobLocations(
    name: 'Riobank',
    id: 3,
  ),
];

