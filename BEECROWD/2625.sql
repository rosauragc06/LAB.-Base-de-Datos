SELECT 
  LPAD(SUBSTRING(cpf, 1, 3), 3, '0') || '.' ||
  LPAD(SUBSTRING(cpf, 4, 3), 3, '0') || '.' ||
  LPAD(SUBSTRING(cpf, 7, 3), 3, '0') || '-' ||
  LPAD(SUBSTRING(cpf, 10, 2), 2, '0') AS CPF
FROM natural_person;