public class InputField {

  public char listen() {
    int keyIndex = 0;
    if ((key >= 'A' && key <= 'Z') || (key >= 'a' && key <= 'z')) {
      System.out.println(key);
    }
    return key;
  }
}