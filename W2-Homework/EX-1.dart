enum Skill { FLUTTER, DART, OTHER }

class Address{
  final String _street;
  final String _city;
  final int _zipCode;

  Address({required this._street, required this._city, required this._zipCode});
  String get street => _street;
  String get city => _city;
  int get zipCode => _zipCode;
}


class Employee {
  String _name;
  double _baseSalary;
  Address _address;
  List<Skill> _skills = [];
  int _yearsOfExperience = 0;

  Employee(this._name, this._baseSalary,  this._skills,  this._address, this._yearsOfExperience);
  Employee.mobileDeveloper(name, baseSalary, address, yearsOfExperience)
  : this(name, baseSalary, [Skill.FLUTTER, Skill.DART], address, yearsOfExperience);

  // Employee.webDev(this._name, this._baseSalary, this._skills, this._address, this._yearsOfExperience);
  // One more Way
  Employee.webDev(this._name, this._baseSalary, this._address, this._yearsOfExperience)
  : _skills =[Skill.OTHER];
  
  String get name => _name;
  double get baseSalary => _baseSalary;
  Address get address => _address;
  List<Skill> get skills => _skills;
  int get experience => _yearsOfExperience;

  double computeTheSalary(){
    double salary;
    salary = _baseSalary + (_yearsOfExperience * 2000);

    _skills.forEach((s){
      if(s == Skill.FLUTTER){
        salary += 5000;
      }else if(s == Skill.DART){
        salary += 3000;
      }else{
        salary += 1000;
      }
    });

    return salary;
  }

  void printDetails() {
    print('Employee: $name, Base Salary: \$${baseSalary}, Skill: ${skills}, Address: (${address.street}, ${address.city}, ${address.zipCode}), Expreience: $experience years');
  }
}

void main() {
  var emp1 = Employee('Sokea', 40000, [Skill.DART] ,Address(street: "Monivong", city: "Phnom Penh", zipCode: 992), 3);
  emp1.printDetails();
  print(emp1.computeTheSalary());
  var test1 = Employee.mobileDeveloper("Ching", 40000.0, Address(street: "HelloWorld", city: "Phnom Penh", zipCode: 206), 1);
  test1.printDetails();
  print(test1.baseSalary);
  print(test1.computeTheSalary());

  var emp2 = Employee.new('Ronan', 45000, [Skill.OTHER, Skill.FLUTTER], Address(street: "road", city: "Phnom Penh", zipCode: 885), 2);
  emp2.printDetails();
  print(emp2.baseSalary);
  print(emp2.computeTheSalary());
  emp2.skills.add(Skill.DART);
  print(emp2.computeTheSalary());

  var test2 = Employee.webDev("Piseth", 20000, Address(street: "Phum1", city: "Kompong Cham", zipCode: 200), 3);
  test2.printDetails();
  print(test2.baseSalary);
  print(test2.computeTheSalary());


}