
import 'package:supercharged/supercharged.dart';
String displayPrice(int price){
 return price.toString().toList().reversed.chunked(3).map((e) => e.reduce((value, element) => value + element)).join('.').reverse;

}