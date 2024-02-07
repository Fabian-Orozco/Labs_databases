/*Constraints: 
  No action
  Cascade
  Set null
  Set default
*/


ALTER TABLE nombreTabla
DROP CONSTRAINT nombreLLave

ALTER TABLE nombreTabla
ADD CONSTRAINT nombreLlave
  FOREIGN Key ...ABS  
  ON DELETE/UPDATE

-- Considerar actualizaciones de llaves con update cascade. Como nombre de negocio.
-- tener cuidado con el Set Null si hay llaves foraneas que sean not null por un caso de totalidad.