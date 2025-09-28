object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'UncleWael'#39's Trinary Logic Demo'
  ClientHeight = 592
  ClientWidth = 792
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object pnlManual: TPanel
    Left = 0
    Top = 81
    Width = 792
    Height = 248
    Align = alTop
    TabOrder = 0
    object Label2: TLabel
      Left = 96
      Top = 109
      Width = 47
      Height = 15
      Caption = 'Operator'
    end
    object Label3: TLabel
      Left = 96
      Top = 64
      Width = 36
      Height = 15
      Caption = 'Engine'
    end
    object Label4: TLabel
      Left = 124
      Top = 6
      Width = 46
      Height = 15
      Caption = 'Workout'
    end
    object btnWorkoutEvaluate: TButton
      Left = 111
      Top = 159
      Width = 99
      Height = 25
      Caption = 'Evaluate'
      TabOrder = 0
      OnClick = btnWorkoutEvaluateClick
    end
    object PSelector: TRadioGroup
      Left = 16
      Top = 56
      Width = 73
      Height = 97
      Caption = 'P'
      ItemIndex = 0
      Items.Strings = (
        'F'
        'T'
        'N')
      TabOrder = 1
    end
    object qSelector: TRadioGroup
      Left = 240
      Top = 56
      Width = 73
      Height = 97
      Caption = 'q'
      ItemIndex = 0
      Items.Strings = (
        'F'
        'T'
        'N')
      TabOrder = 2
    end
    object lbOperators: TComboBox
      Left = 95
      Top = 125
      Width = 140
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 3
      Text = 'and'
      Items.Strings = (
        'and'
        'or'
        'implies (=>)'
        'Xor'
        'not p'
        'not q'
        'logical equivalence (*)'
        'XNor'
        'NAnd'
        'Nor'
        'p to Boolean (go easy)'
        'p to Boolean (unforgiving)'
        'data equivalence'
        '')
    end
    object lbFrameworks: TComboBox
      Left = 95
      Top = 80
      Width = 140
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 4
      Text = 'teKleene'
      OnChange = lbFrameworksChange
      Items.Strings = (
        'teKleene'
        'teLukasiewicz'
        'teBochvarInternal'
        'teBochvarExternal')
    end
    object ResultScreen: TMemo
      Left = 319
      Top = 1
      Width = 472
      Height = 246
      Align = alRight
      Lines.Strings = (
        'Default inference engine is teKleene')
      TabOrder = 5
    end
  end
  object pnlTitle: TPanel
    Left = 0
    Top = 0
    Width = 792
    Height = 81
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 180
      Height = 15
      Caption = 'UncleWael'#39's Trinary Logic Demo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pnlJson: TPanel
    Left = 0
    Top = 329
    Width = 792
    Height = 263
    Align = alClient
    TabOrder = 2
    object Label5: TLabel
      Left = 124
      Top = 6
      Width = 61
      Height = 15
      Caption = 'JSON Mock'
    end
    object Label6: TLabel
      Left = 16
      Top = 32
      Width = 26
      Height = 15
      Caption = 'Price'
    end
    object Label7: TLabel
      Left = 16
      Top = 88
      Width = 249
      Height = 60
      Caption = 
        'Try modify the price and re-evaluate. any price < 100 passes , p' +
        'rice >= 100 fails. Also try to enter invalid (alpha) price , and' +
        ' try leave blank , and evaluate'
      WordWrap = True
    end
    object JSONMock: TMemo
      Left = 319
      Top = 1
      Width = 472
      Height = 261
      Align = alRight
      TabOrder = 0
    end
    object edPrice: TEdit
      Left = 16
      Top = 48
      Width = 180
      Height = 23
      TabOrder = 1
      Text = '50'
      OnChange = edPriceChange
    end
    object btnJsonEvaluate: TButton
      Left = 111
      Top = 175
      Width = 99
      Height = 25
      Caption = 'Evaluate'
      TabOrder = 2
      OnClick = btnJsonEvaluateClick
    end
  end
end
