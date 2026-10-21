class BankAccount {
    // TODO
    int accountId;
    String accountOwner;
    // String password;
    double amount = 0;

    BankAccount({required this.accountId, required this.accountOwner, /*required this.password,*/ this.amount = 0});

    double balance(){
      return amount;
    }

    double withdraw(double amount){
      if(this.amount - amount < 0){
        throw Exception("Insufficient balance for withdrawal!");
      }
      return this.amount -= amount;
    }

    double credit(double amount){
      return this.amount += amount;
    }
}

class Bank {
    // TODO
    List<BankAccount> accounts = [];

    BankAccount createAccount(int accountId, String accountOwner){
      for(BankAccount a in accounts){
        if(a.accountId == accountId){
          throw Exception("Account with ID $accountId already exists!");
        }
      }
      BankAccount newAccount = BankAccount(accountId: accountId, accountOwner: accountOwner);
      accounts.add(newAccount);
      return newAccount;
    }
}

void main() {

  // Bank myBank = Bank(name: "CADT Bank");
  Bank myBank = Bank();
  BankAccount ronanAccount = myBank.createAccount(100, 'Ronan');

  print(ronanAccount.balance()); // Balance: $0
  ronanAccount.credit(100);
  print(ronanAccount.balance()); // Balance: $100
  ronanAccount.withdraw(50);
  print(ronanAccount.balance()); // Balance: $50

  try {
    ronanAccount.withdraw(75); // This will throw an exception
  } catch (e) {
    print(e); // Output: Insufficient balance for withdrawal!
  }

  try {
    myBank.createAccount(100, 'Honlgy'); // This will throw an exception
  } catch (e) {
    print(e); // Output: Account with ID 100 already exists!
  }
}
