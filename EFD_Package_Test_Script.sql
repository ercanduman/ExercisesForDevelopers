BEGIN
  -- challange no 1:
  dbms_output.put_line(chr(10) || 'Challange 1:');
  --eduman.efd.SayingHello(pis_Name => 'Ercan Duman');

  -- challange no 2:
  dbms_output.put_line(chr(10) || 'Challange 2:');
  --eduman.efd.CountingTheNumberOfCharacters(pis_InputSring => 'Homer');

  -- challange no 3:
  dbms_output.put_line(chr(10) || 'Challange 3:');
  --eduman.efd.PrintingQuotes(pis_Quote => 'These aren''t the droids you''re looking for.', pis_Author => 'Obi-Wan Kenobi');

  -- challange no 5:
  dbms_output.put_line(chr(10) || 'Challange 5:');
  --  eduman.efd.SimpleMath(pin_FirstNumber => 10, pin_SecondNumber => 5);

  -- challange no 6:
  dbms_output.put_line(chr(10) || 'Challange 6:');
  eduman.efd.RetirementCalculator(pin_UserAge => 25, pin_RetirementAge => 65);
END;
