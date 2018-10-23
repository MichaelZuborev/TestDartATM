
//Кдасс представляет купюру
class Banknote{
  //Номинал купюры
  int denomination;

  Banknote(int value){
    if(value <= 0){
      denomination = 1;
    }else{
      denomination = value;
    }
  }

  int get(){
    return denomination;
  }

  bool equals(Banknote that){
    return this.get() == that.get();
  }
}