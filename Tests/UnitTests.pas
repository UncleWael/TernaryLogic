unit UnitTests;

interface

uses DUnitX.TestFramework, TernaryLogic;

type

  [TestFixture]
  TTernaryLogicTestObject = class
  private
    function _ValLetterToVal(L: char): TTernaryValue;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    // The Negation test
    [Test]
    [TestCase('not F [Kleene]', '0,F,T')]
    [TestCase('not T [Kleene]', '0,T,F')]
    [TestCase('not N [Kleene]', '0,N,N')]
    [TestCase('not F [Lukasiewicz]', '1,F,T')]
    [TestCase('not T [Lukasiewicz]', '1,T,F')]
    [TestCase('not N [Lukasiewicz]', '1,N,N')]
    [TestCase('not F [Bochvar Internal]', '2,F,T')]
    [TestCase('not T [Bochvar Internal]', '2,T,F')]
    [TestCase('not N [Bochvar Internal]', '2,N,N')]
    [TestCase('not F [Bochvar Exterrnal]', '3,F,T')]
    [TestCase('not T [Bochvar Exterrnal]', '3,T,F')]
    [TestCase('not N [Bochvar Exterrnal]', '3,N,T')]
    procedure TestNegation(const frameworkIDX: byte; const Operand1: char;
      const cExpected: char);

    // The Conjunction test
    [Test]
    [TestCase('F and F [Kleene]', '0,F,F,F')]
    [TestCase('F and T [Kleene]', '0,F,T,F')]
    [TestCase('F and N [Kleene]', '0,F,N,F')]
    [TestCase('T and F [Kleene]', '0,T,F,F')]
    [TestCase('T and T [Kleene]', '0,T,T,T')]
    [TestCase('T and N [Kleene]', '0,T,N,N')]
    [TestCase('N and F [Kleene]', '0,N,F,F')]
    [TestCase('N and T [Kleene]', '0,N,T,N')]
    [TestCase('N and N [Kleene]', '0,N,N,N')]
    [TestCase('F and F [Lukasiewicz]', '1,F,F,F')]
    [TestCase('F and T [Lukasiewicz]', '1,F,T,F')]
    [TestCase('F and N [Lukasiewicz]', '1,F,N,F')]
    [TestCase('T and F [Lukasiewicz]', '1,T,F,F')]
    [TestCase('T and T [Lukasiewicz]', '1,T,T,T')]
    [TestCase('T and N [Lukasiewicz]', '1,T,N,N')]
    [TestCase('N and F [Lukasiewicz]', '1,N,F,F')]
    [TestCase('N and T [Lukasiewicz]', '1,N,T,N')]
    [TestCase('N and N [Lukasiewicz]', '1,N,N,N')]
    [TestCase('F and F [Bochvar Internal]', '2,F,F,F')]
    [TestCase('F and T [Bochvar Internal]', '2,F,T,F')]
    [TestCase('F and N [Bochvar Internal]', '2,F,N,N')]
    [TestCase('T and F [Bochvar Internal]', '2,T,F,F')]
    [TestCase('T and T [Bochvar Internal]', '2,T,T,T')]
    [TestCase('T and N [Bochvar Internal]', '2,T,N,N')]
    [TestCase('N and F [Bochvar Internal]', '2,N,F,N')]
    [TestCase('N and T [Bochvar Internal]', '2,N,T,N')]
    [TestCase('N and N [Bochvar Internal]', '2,N,N,N')]
    [TestCase('F and F [Bochvar Exterrnal]', '3,F,F,F')]
    [TestCase('F and T [Bochvar Exterrnal]', '3,F,T,F')]
    [TestCase('F and N [Bochvar Exterrnal]', '3,F,N,F')]
    [TestCase('T and F [Bochvar Exterrnal]', '3,T,F,F')]
    [TestCase('T and T [Bochvar Exterrnal]', '3,T,T,T')]
    [TestCase('T and N [Bochvar Exterrnal]', '3,T,N,F')]
    [TestCase('N and F [Bochvar Exterrnal]', '3,N,F,F')]
    [TestCase('N and T [Bochvar Exterrnal]', '3,N,T,F')]
    [TestCase('N and N [Bochvar Exterrnal]', '3,N,N,F')]
    procedure TestConjunction(const frameworkIDX: byte; const Operand1: char;
      const Operand2: char; const cExpected: char);

    // The disjunction test
    [Test]
    [TestCase('F or F [Kleene]', '0,F,F,F')]
    [TestCase('F or T [Kleene]', '0,F,T,T')]
    [TestCase('F or N [Kleene]', '0,F,N,N')]
    [TestCase('T or F [Kleene]', '0,T,F,T')]
    [TestCase('T or T [Kleene]', '0,T,T,T')]
    [TestCase('T or N [Kleene]', '0,T,N,T')]
    [TestCase('N or F [Kleene]', '0,N,F,N')]
    [TestCase('N or T [Kleene]', '0,N,T,T')]
    [TestCase('N or N [Kleene]', '0,N,N,N')]
    [TestCase('F or F [Lukasiewicz]', '1,F,F,F')]
    [TestCase('F or T [Lukasiewicz]', '1,F,T,T')]
    [TestCase('F or N [Lukasiewicz]', '1,F,N,N')]
    [TestCase('T or F [Lukasiewicz]', '1,T,F,T')]
    [TestCase('T or T [Lukasiewicz]', '1,T,T,T')]
    [TestCase('T or N [Lukasiewicz]', '1,T,N,T')]
    [TestCase('N or F [Lukasiewicz]', '1,N,F,N')]
    [TestCase('N or T [Lukasiewicz]', '1,N,T,T')]
    [TestCase('N or N [Lukasiewicz]', '1,N,N,N')]
    [TestCase('F or F [Bochvar Internal]', '2,F,F,F')]
    [TestCase('F or T [Bochvar Internal]', '2,F,T,T')]
    [TestCase('F or N [Bochvar Internal]', '2,F,N,N')]
    [TestCase('T or F [Bochvar Internal]', '2,T,F,T')]
    [TestCase('T or T [Bochvar Internal]', '2,T,T,T')]
    [TestCase('T or N [Bochvar Internal]', '2,T,N,N')]
    [TestCase('N or F [Bochvar Internal]', '2,N,F,N')]
    [TestCase('N or T [Bochvar Internal]', '2,N,T,N')]
    [TestCase('N or N [Bochvar Internal]', '2,N,N,N')]
    [TestCase('F or F [Bochvar Exterrnal]', '3,F,F,F')]
    [TestCase('F or T [Bochvar Exterrnal]', '3,F,T,T')]
    [TestCase('F or N [Bochvar Exterrnal]', '3,F,N,F')]
    [TestCase('T or F [Bochvar Exterrnal]', '3,T,F,T')]
    [TestCase('T or T [Bochvar Exterrnal]', '3,T,T,T')]
    [TestCase('T or N [Bochvar Exterrnal]', '3,T,N,T')]
    [TestCase('N or F [Bochvar Exterrnal]', '3,N,F,F')]
    [TestCase('N or T [Bochvar Exterrnal]', '3,N,T,T')]
    [TestCase('N or N [Bochvar Exterrnal]', '3,N,N,F')]
    procedure TestDisjunction(const frameworkIDX: byte; const Operand1: char;
      const Operand2: char; const cExpected: char);

    // The implication test
    [Test]
    [TestCase('F implies F [Kleene]', '0,F,F,T')]
    [TestCase('F implies T [Kleene]', '0,F,T,T')]
    [TestCase('F implies N [Kleene]', '0,F,N,T')]
    [TestCase('T implies F [Kleene]', '0,T,F,F')]
    [TestCase('T implies T [Kleene]', '0,T,T,T')]
    [TestCase('T implies N [Kleene]', '0,T,N,N')]
    [TestCase('N implies F [Kleene]', '0,N,F,N')]
    [TestCase('N implies T [Kleene]', '0,N,T,T')]
    [TestCase('N implies N [Kleene]', '0,N,N,N')]
    [TestCase('F implies F [Lukasiewicz]', '1,F,F,T')]
    [TestCase('F implies T [Lukasiewicz]', '1,F,T,T')]
    [TestCase('F implies N [Lukasiewicz]', '1,F,N,T')]
    [TestCase('T implies F [Lukasiewicz]', '1,T,F,F')]
    [TestCase('T implies T [Lukasiewicz]', '1,T,T,T')]
    [TestCase('T implies N [Lukasiewicz]', '1,T,N,N')]
    [TestCase('N implies F [Lukasiewicz]', '1,N,F,N')]
    [TestCase('N implies T [Lukasiewicz]', '1,N,T,T')]
    [TestCase('N implies N [Lukasiewicz]', '1,N,N,T')]
    [TestCase('F implies F [Bochvar Internal]', '2,F,F,T')]
    [TestCase('F implies T [Bochvar Internal]', '2,F,T,T')]
    [TestCase('F implies N [Bochvar Internal]', '2,F,N,N')]
    [TestCase('T implies F [Bochvar Internal]', '2,T,F,F')]
    [TestCase('T implies T [Bochvar Internal]', '2,T,T,T')]
    [TestCase('T implies N [Bochvar Internal]', '2,T,N,N')]
    [TestCase('N implies F [Bochvar Internal]', '2,N,F,N')]
    [TestCase('N implies T [Bochvar Internal]', '2,N,T,N')]
    [TestCase('N implies N [Bochvar Internal]', '2,N,N,N')]
    [TestCase('F implies F [Bochvar Exterrnal]', '3,F,F,T')]
    [TestCase('F implies T [Bochvar Exterrnal]', '3,F,T,T')]
    [TestCase('F implies N [Bochvar Exterrnal]', '3,F,N,T')]
    [TestCase('T implies F [Bochvar Exterrnal]', '3,T,F,F')]
    [TestCase('T implies T [Bochvar Exterrnal]', '3,T,T,T')]
    [TestCase('T implies N [Bochvar Exterrnal]', '3,T,N,F')]
    [TestCase('N implies F [Bochvar Exterrnal]', '3,N,F,T')]
    [TestCase('N implies T [Bochvar Exterrnal]', '3,N,T,T')]
    [TestCase('N implies N [Bochvar Exterrnal]', '3,N,N,T')]
    procedure TestImplication(const frameworkIDX: byte; const Operand1: char;
      const Operand2: char; const cExpected: char);
  end;

implementation

uses typinfo, sysutils;

procedure TTernaryLogicTestObject.Setup;
begin
  // nothing needed for now, reserved for future need
end;

procedure TTernaryLogicTestObject.TearDown;
begin
  // nothing needed for now, reserved for future need
end;

function TTernaryLogicTestObject._ValLetterToVal(L: char): TTernaryValue;
begin
  L := UpCase(L);
  if L = 'F' Then result := F
  else if L = 'T' Then result := T
  else if L = 'N' Then result := N
  else raise EConvertError.Create('Invalid value letter');

end;

procedure TTernaryLogicTestObject.TestConjunction(const frameworkIDX: byte;
  const Operand1, Operand2, cExpected: char);
var p, q, r: TTernaryLogic; Expected: TTernaryValue;
  framework: TTernaryInferenceFramework;
begin
  framework := TTernaryInferenceFramework(frameworkIDX);
  p.Value := _ValLetterToVal(Operand1);
  q.Value := _ValLetterToVal(Operand2);
  Expected := _ValLetterToVal(cExpected);

  p.framework := framework;
  q.framework := framework;

  r := p and q;

  Assert.AreEqual(r.Value, Expected,
    '[' + GetEnumName(TypeInfo(TTernaryInferenceFramework),
    Ord(frameworkIDX)) + ']');

end;

procedure TTernaryLogicTestObject.TestDisjunction(const frameworkIDX: byte;
  const Operand1, Operand2, cExpected: char);
var p, q, r: TTernaryLogic; Expected: TTernaryValue;
  framework: TTernaryInferenceFramework;
begin
  framework := TTernaryInferenceFramework(frameworkIDX);
  p.Value := _ValLetterToVal(Operand1);
  q.Value := _ValLetterToVal(Operand2);
  Expected := _ValLetterToVal(cExpected);

  p.framework := framework;
  q.framework := framework;

  r := p or q;

  Assert.AreEqual(r.Value, Expected,
    '[' + GetEnumName(TypeInfo(TTernaryInferenceFramework),
    Ord(frameworkIDX)) + ']');

end;

procedure TTernaryLogicTestObject.TestImplication(const frameworkIDX: byte;
  const Operand1: char; const Operand2: char; const cExpected: char);
var p, q, r: TTernaryLogic; Expected: TTernaryValue;
  framework: TTernaryInferenceFramework;
begin
  framework := TTernaryInferenceFramework(frameworkIDX);
  p.Value := _ValLetterToVal(Operand1);
  q.Value := _ValLetterToVal(Operand2);
  Expected := _ValLetterToVal(cExpected);

  p.framework := framework;
  q.framework := framework;

  r := p > q;

  Assert.AreEqual(r.Value, Expected,
    '[' + GetEnumName(TypeInfo(TTernaryInferenceFramework),
    Ord(frameworkIDX)) + ']');

end;

procedure TTernaryLogicTestObject.TestNegation(const frameworkIDX: byte;
  const Operand1, cExpected: char);
var p, r: TTernaryLogic; Expected: TTernaryValue;
  framework: TTernaryInferenceFramework;
begin
  framework := TTernaryInferenceFramework(frameworkIDX);
  p.Value := _ValLetterToVal(Operand1);
  Expected := _ValLetterToVal(cExpected);

  p.framework := framework;

  r := not p;

  Assert.AreEqual(r.Value, Expected,
    '[' + GetEnumName(TypeInfo(TTernaryInferenceFramework),
    Ord(frameworkIDX)) + ']');

end;

initialization

TDUnitX.RegisterTestFixture(TTernaryLogicTestObject);

end.
