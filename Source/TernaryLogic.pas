unit TernaryLogic;

{ Ternary Logic Library version 1.0a
  --------------------------------
  Author   : Wael M. Hassan (UncleWael)
  Github   : https://github.com/UncleWael
  Linkedin : https://www.linkedin.com/in/wael-m-hassan/
  Compatability : Delphi 10.4 and up , for managed records support
  License : MIT license
}

interface

Type
  TTernaryValue = (F, T, N);
  TTernaryInferenceFramework = (fKleene, fLukasiewicz, fBochvarInternal,
    fBochvarExternal);

  TTernaryLogic = record
    Value: TTernaryValue;
    Framework: TTernaryInferenceFramework;

  public
    procedure Initialize;

    { overloaded operators }
    class operator Equal(const p, q: TTernaryLogic): Boolean;
    class operator NotEqual(const p, q: TTernaryLogic): Boolean;
    class operator LogicalNot(const p: TTernaryLogic): TTernaryLogic;
    class operator LogicalAnd(const p, q: TTernaryLogic): TTernaryLogic;
    class operator LogicalOr(const p, q: TTernaryLogic): TTernaryLogic;
    class operator LogicalXor(const p, q: TTernaryLogic): TTernaryLogic;
    class operator Multiply(const p, q: TTernaryLogic): TTernaryLogic;
    // uses Eq3 class method
    class operator GreaterThan { OrEqual } (const p, q: TTernaryLogic)
      : TTernaryLogic; // uses Implies class method

    { basic class methods }
    class function EqData(const p, q: TTernaryLogic): Boolean; overload; static;
    class function Eq3(const p, q: TTernaryLogic): TTernaryLogic; overload;
      static; { * operator, because Delphi does not allow non-boolean = operator overload }
    class function Implies(const p, q: TTernaryLogic): TTernaryLogic; overload;
      static; { > operator, same mathematical shape }
    class function XNor(p, q: TTernaryLogic): TTernaryLogic; overload; static;
    class function NAnd(p, q: TTernaryLogic): TTernaryLogic; overload; static;
    class function Nor(p, q: TTernaryLogic): TTernaryLogic; overload; static;

    class function ToBoolean(p: TTernaryValue; goEasy: Boolean = true): Boolean;
      overload; static;
    class function ToInteger(p: TTernaryValue): Integer; overload; static;
    class function ToString(p: TTernaryValue): String; overload; static;

    { overload member functions , for the developer's convenience }
    function EqData(const q: TTernaryLogic): Boolean; overload;
    function Eq3(const q: TTernaryLogic): TTernaryLogic; overload;
    function Implies(const q: TTernaryLogic): TTernaryLogic; overload;
    function XNor(q: TTernaryLogic): TTernaryLogic; overload;
    function NAnd(q: TTernaryLogic): TTernaryLogic; overload;
    function Nor(q: TTernaryLogic): TTernaryLogic; overload;

    function ToBoolean(goEasy: Boolean = true): Boolean; overload;
    function ToInteger: Integer; overload;
    function ToString: String; overload;
    function FromBoolean(BoolVal: Boolean): TTernaryLogic;

  end;

implementation

uses System.SysUtils;

{ TTernaryLogic }

procedure TTernaryLogic.Initialize;
begin
  Framework := fKleene;
  // default Framework only because it is more common in practice, no privilege
  Value := N;
end;

class operator TTernaryLogic.Equal(const p, q: TTernaryLogic): Boolean;
begin
  // Delphi constrain: = and <> has to be binary , so we are to disable the use of = and <> operators for TrenaryLogic
  raise EMathError.Create('To check TrenaryLogic equality , use Eq3 function.');
end;

function TTernaryLogic.FromBoolean(BoolVal: Boolean): TTernaryLogic;
begin
  if BoolVal then self.Value := T
  else self.Value := F;
  result := self;

end;

class operator TTernaryLogic.NotEqual(const p, q: TTernaryLogic): Boolean;
begin
  // Delphi constrain: = and <> has to be binary , so we are to disable the use of = and <> operators for TrenaryLogic
  raise EMathError.Create('To check TrenaryLogic equality , use Eq3 function.');
end;

class operator TTernaryLogic.LogicalNot(const p: TTernaryLogic): TTernaryLogic;
begin
  result.Framework := p.Framework;

  case p.Value of
  T: result.Value := F;
  F: result.Value := T;
  N: result.Value := N;
  end;
  if (p.Framework = fBochvarExternal) and (p.Value = N) then result.Value := T;

end;

class operator TTernaryLogic.LogicalAnd(const p, q: TTernaryLogic)
  : TTernaryLogic;
begin
  if p.Framework <> q.Framework then
      raise EMathError.Create('TrenaryLogic Framework mismatch');

  result.Framework := p.Framework;
  result.Value := F; // default is false

  if (p.Value = T) and (q.Value = T) then result.Value := T;
  // if both are true, then true

  case p.Framework of
  fKleene, fLukasiewicz:
    if (((p.Value = N) and (q.Value = T))) or (((q.Value = N) and (p.Value = T))
      ) or (((p.Value = N) and (q.Value = N))) then result.Value := N;
  fBochvarInternal: if (p.Value = N) or (q.Value = N) then result.Value := N;
  // the result of N and any thing is N
  fBochvarExternal: { same as propositional, N is ignored };
  end;

end;

class operator TTernaryLogic.LogicalOr(const p, q: TTernaryLogic)
  : TTernaryLogic;
begin
  if p.Framework <> q.Framework then
      raise EMathError.Create('TrenaryLogic Framework mismatch');

  result.Framework := p.Framework;

  result.Value := T; // default is True

  if (p.Value = F) and (q.Value = F) then result.Value := F;
  // if both are true, then true

  case p.Framework of
  fKleene, fLukasiewicz:
    if (((p.Value = N) and (q.Value = F))) or (((q.Value = N) and (p.Value = F))
      ) or (((p.Value = N) and (q.Value = N))) then result.Value := N;
  fBochvarInternal: if (p.Value = N) or (q.Value = N) then result.Value := N;
  // the result of N or any thing is N
  fBochvarExternal: if (p.Value = N) or (q.Value = N) then begin
      // the result of N or any non-true is F , but with true is T
      if ((p.Value = N) and (q.Value = T)) or ((p.Value = T) and (q.Value = N))
      then result.Value := T
      else result.Value := F;
    end;
  end;

end;

class operator TTernaryLogic.LogicalXor(const p, q: TTernaryLogic)
  : TTernaryLogic;
begin
  if p.Framework <> q.Framework then
      raise EMathError.Create('TrenaryLogic Framework mismatch');
  result.Framework := p.Framework;

  if (p.Value = N) or (q.Value = N) then result.Value := N
    // Uncertainity propagates
  else if (p.Value = q.Value) then result.Value := F
  else result.Value := T;
  // xor is True when operands do not have the same truth value

end;

class operator TTernaryLogic.Multiply(const p, q: TTernaryLogic): TTernaryLogic;
begin
  // the * operator
  result := Eq3(p, q);
end;

class operator TTernaryLogic.GreaterThan { OrEqual } (const p, q: TTernaryLogic)
  : TTernaryLogic;
begin
  // the => operator
  result := Implies(p, q);
end;

class function TTernaryLogic.EqData(const p, q: TTernaryLogic): Boolean;
begin
  result := (p.Framework = q.Framework) and (p.Value = q.Value);
end;

class function TTernaryLogic.Eq3(const p, q: TTernaryLogic): TTernaryLogic;
begin
  if p.Framework <> q.Framework then
      raise EMathError.Create('TrenaryLogic Framework mismatch');
  result.Framework := p.Framework;

  if (p.Value = q.Value) then result.Value := T
  else result.Value := F; // default

  case p.Framework of
  fKleene, fBochvarInternal: if (p.Value = N) or (q.Value = N) then
        result.Value := N; // the result of N equivalent to anything is N
  fBochvarExternal:
    if ((p.Value = F) and (q.Value = N)) or ((p.Value = N) and (q.Value = F))
    then result.Value := T; { F, N are equivalent }
  fLukasiewicz:
    if ((p.Value = N) or (q.Value = N)) and (p.Value <> q.Value) then
        result.Value := N;
  // the result of N equivalent to anything is N , except N <=> N is T
  end;
end;

class function TTernaryLogic.Implies(const p, q: TTernaryLogic): TTernaryLogic;
begin
  if p.Framework <> q.Framework then
      raise EMathError.Create('TrenaryLogic Framework mismatch');

  result.Framework := p.Framework;

  // the most truth cases in the boolean implication are True
  result.Value := T;

  // premise is True and conclusion is False ,is the only case where the boolean implication will be False
  if (p.Value = T) and (q.Value = F) then result.Value := F;

  // the problematic case in the trenary logic is when one of the operands is N, what will be the value of the implication ?!
  // here the inference REALLY differs !
  case p.Framework of
  fKleene: if (((p.Value = T) and (q.Value = N))) or
      (((p.Value = N) and (q.Value = F))) or (((p.Value = N) and (q.Value = N)))
    then result.Value := N;
  fLukasiewicz:
    if (((p.Value = T) and (q.Value = N))) or (((p.Value = N) and (q.Value = F))
      ) { N->N is T  in luka } then result.Value := N;
  fBochvarInternal: if (p.Value = N) or (q.Value = N) then result.Value := N;
  // the result of N implies any thing, or any thing implies N is N
  fBochvarExternal: if (p.Value = T) and (q.Value = N) then result.Value := F;
  // the result of T implies N is False , but the revers is true
  end;

end;

class function TTernaryLogic.XNor(p, q: TTernaryLogic): TTernaryLogic;
begin
  result := not(p xor q);
end;

class function TTernaryLogic.NAnd(p, q: TTernaryLogic): TTernaryLogic;
begin
  result := not(p and q);
end;

class function TTernaryLogic.Nor(p, q: TTernaryLogic): TTernaryLogic;
begin
  result := not(p or q);
end;

class function TTernaryLogic.ToBoolean(p: TTernaryValue;
  goEasy: Boolean = true): Boolean;
begin
  // if go easy is active , then every thing that is not True will be considered False,
  // else , an exception will be raised for the N state, because it is not compatabile with the binary system
  case p of
  T: result := true;
  F: result := false;
else if goEasy then result := false
  else raise EMathError.Create('TrenaryLogic value out of boolean range');
  end;

end;

class function TTernaryLogic.ToInteger(p: TTernaryValue): Integer;
begin
  result := ord(p);
end;

class function TTernaryLogic.ToString(p: TTernaryValue): String;
begin
  case p of
  F: result := 'F';
  T: result := 'T';
  N: result := 'N';
  end;

end;

function TTernaryLogic.ToBoolean(goEasy: Boolean = true): Boolean;
begin
  result := ToBoolean(Value, goEasy);
end;

function TTernaryLogic.ToInteger: Integer;
begin
  result := ord(Value);
end;

function TTernaryLogic.ToString: String;
begin
  result := ToString(Value);
end;

function TTernaryLogic.EqData(const q: TTernaryLogic): Boolean;
begin
  result := EqData(self, q);
end;

function TTernaryLogic.Eq3(const q: TTernaryLogic): TTernaryLogic;
begin
  result := Eq3(self, q);
end;

function TTernaryLogic.Implies(const q: TTernaryLogic): TTernaryLogic;
begin
  result := Implies(self, q);
end;

function TTernaryLogic.XNor(q: TTernaryLogic): TTernaryLogic;
begin
  result := XNor(self, q);
end;

function TTernaryLogic.NAnd(q: TTernaryLogic): TTernaryLogic;
begin
  result := NAnd(self, q);
end;

function TTernaryLogic.Nor(q: TTernaryLogic): TTernaryLogic;
begin
  result := Nor(self, q);
end;

end.
