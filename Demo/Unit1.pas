unit Unit1;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, TernaryLogic;

type
  TForm1 = class(TForm)
    pnlManual: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    btnWorkoutEvaluate: TButton;
    PSelector: TRadioGroup;
    qSelector: TRadioGroup;
    lbOperators: TComboBox;
    lbFrameworks: TComboBox;
    Label4: TLabel;
    ResultScreen: TMemo;
    pnlTitle: TPanel;
    Label1: TLabel;
    pnlJson: TPanel;
    Label5: TLabel;
    JSONMock: TMemo;
    edPrice: TEdit;
    Label6: TLabel;
    btnJsonEvaluate: TButton;
    Label7: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnWorkoutEvaluateClick(Sender: TObject);
    procedure btnJsonEvaluateClick(Sender: TObject);
    procedure edPriceChange(Sender: TObject);
    procedure lbFrameworksChange(Sender: TObject);
  private
    { Private declarations }
    procedure ConstructJSON;
    function EvaluateJSON(JSONResponse: String): TTernaryLogic;
  public
    { Public declarations }
  end;

var Form1: TForm1;

implementation

{$R *.dfm}

uses System.JSON;

const pricelimit = 99;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ConstructJSON;
end;

procedure TForm1.lbFrameworksChange(Sender: TObject);
begin
  ResultScreen.Lines.Add('Inference Framework changed to: ' + lbFrameworks.Items
    [lbFrameworks.ItemIndex]);
end;

procedure TForm1.btnWorkoutEvaluateClick(Sender: TObject);
var p, q, r: TTernaryLogic;
begin
  p.Framework := TTernaryInferenceFramework(lbFrameworks.ItemIndex);
  q.Framework := TTernaryInferenceFramework(lbFrameworks.ItemIndex);

  p.Value := TTernaryValue(PSelector.ItemIndex);
  q.Value := TTernaryValue(qSelector.ItemIndex);

  case lbOperators.ItemIndex of
  0: begin
      r := p and q;
      ResultScreen.Lines.Add('p and q = ' + r.ToString);
    end;
  1: begin
      r := p or q;
      ResultScreen.Lines.Add('p or q = ' + r.ToString);
    end;
  2: begin
      r := p > q;
      ResultScreen.Lines.Add('p implies q =' + r.ToString);
    end;
  3: begin
      r := p xor q;
      ResultScreen.Lines.Add('p xor q = ' + r.ToString);
    end;
  4: begin
      r := not p;
      ResultScreen.Lines.Add('not p = ' + r.ToString);
    end;
  5: begin
      r := not q;
      ResultScreen.Lines.Add('not q = ' + r.ToString);
    end;
  6: begin
      r := p * q;
      ResultScreen.Lines.Add('Equivalence of p , q = ' + r.ToString);
    end;

  7: begin
      r := p.XNor(q);
      ResultScreen.Lines.Add('p xnor q =' + r.ToString);
    end;
  8: begin
      r := p.NAnd(q);
      ResultScreen.Lines.Add('p nand q =' + r.ToString);
    end;
  9: begin
      r := p.Nor(q);
      ResultScreen.Lines.Add('p nor q =' + r.ToString);
    end;
  10: ResultScreen.Lines.Add('p to Boolean (easy) = ' +
      BoolToStr(p.ToBoolean, true));
  11: ResultScreen.Lines.Add('p to Boolean (unforgiving)= ' +
      BoolToStr(p.ToBoolean(False), False));

else if p.EqData(q) then ResultScreen.Lines.Add('p , q are data equivalent')
  else ResultScreen.Lines.Add('p , q has are data different')

  end;

end;

procedure TForm1.ConstructJSON;
begin
  JSONMock.Text :=
    format('{"Product":"HP Laserjet Toner Carteidge","UnitPrice":%s ,"Quanitity":20}',
    [edPrice.Text]);

end;

procedure TForm1.edPriceChange(Sender: TObject);
begin
  ConstructJSON;
end;

function TForm1.EvaluateJSON(JSONResponse: String): TTernaryLogic;
var JsonValue: TJSONValue; JsonObj: TJSONObject; Num: Double;
begin
  Result.Framework := fLukasiewicz;
  JsonValue := TJSONObject.ParseJSONValue(JSONResponse);
  try
    try
      if JsonValue is TJSONObject then begin
        JsonObj := JsonValue as TJSONObject;
        Num := JsonObj.GetValue<Double>('UnitPrice');
        Result.FromBoolean(Num <= pricelimit);
      end
      else Result.Value := N;
    except
      on Exception do Result.Value := N;
    end;
  finally JsonValue.Free;
  end;
end;

procedure TForm1.btnJsonEvaluateClick(Sender: TObject);
begin
  case EvaluateJSON(JSONMock.Text).Value of
  T: ShowMessage('Price is affordable, placing order ...');
  F: ShowMessage('Price is too high, order rejected.');
  N: ShowMessage
      ('Unknown price, order postponed , please report to your supervisor');
  end;
end;

end.
