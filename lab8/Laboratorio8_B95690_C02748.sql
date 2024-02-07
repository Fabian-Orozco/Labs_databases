/* Trabajo en parejas
  Fabián Orozco Chaves - B95690
  Daniel Escobar Giraldo - C02748 
*/

use B95690
-- Escenario 1. read uncommitted
-- Insert into Lleva values ('0123456789', 'CI0126', 1, 2, 2014, 75);
-- Insert into Lleva values ('1111111111', 'CI0126', 1, 2, 2014, 80);
-- Insert into Lleva values ('2222222222', 'CI0126', 2, 2, 2014, 85);
-- Insert into Lleva values ('3333333333', 'CI0126', 2, 2, 2014, 90);

-- Ejercicio 4. Sesión A -- 
use B95690;
set transaction isolation 
level read uncommitted; 
 
begin transaction t1; 
PRINT @@TRANCOUNT 

Select avg(Nota) from Lleva;

-- Ejercicio 6. Sesión A -- 
Select avg(Nota) from Lleva;
Commit transaction t1;
