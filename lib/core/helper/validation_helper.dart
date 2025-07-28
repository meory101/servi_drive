
abstract class ValidationHelper{
 static bool checkNumberStatsWithZero(String phone){
   if (phone.startsWith("0")) {
     return true;
   }

   return false;
 }


}