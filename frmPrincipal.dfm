object frmTesteCM: TfrmTesteCM
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 428
  ClientWidth = 526
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgcTeste: TPageControl
    Left = 0
    Top = 0
    Width = 526
    Height = 428
    ActivePage = tsPesquisaLista
    Align = alClient
    TabOrder = 0
    object tsPesquisaLista: TTabSheet
      Caption = 'Pesquisa Lista'
      ExplicitLeft = 8
      ExplicitTop = 28
      object lbl1: TLabel
        Left = 3
        Top = 3
        Width = 267
        Height = 13
        Caption = 'Valor a ser pesquisado em uma lista de 50000 registros.'
        WordWrap = True
      end
      object btn1: TButton
        Left = 3
        Top = 53
        Width = 75
        Height = 25
        Caption = 'Pesquisar'
        TabOrder = 0
        OnClick = btn1Click
      end
      object edt1: TEdit
        Left = 3
        Top = 26
        Width = 151
        Height = 21
        NumbersOnly = True
        TabOrder = 1
        OnKeyDown = edt1KeyDown
      end
    end
    object tsConversaoJSON: TTabSheet
      Caption = 'Converter JSON'
      ImageIndex = 1
      object lbl11: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 183
        Width = 512
        Height = 13
        Align = alTop
        Caption = 'JSON Formado'
        ExplicitWidth = 71
      end
      object pnl1: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 512
        Height = 174
        Align = alTop
        BevelKind = bkSoft
        BevelOuter = bvNone
        Caption = 'pnl1'
        ShowCaption = False
        TabOrder = 0
        object lbl2: TLabel
          Left = 8
          Top = 8
          Width = 27
          Height = 13
          Caption = 'Nome'
        end
        object lbl3: TLabel
          Left = 8
          Top = 54
          Width = 55
          Height = 13
          Caption = 'Logradouro'
        end
        object lbl4: TLabel
          Left = 436
          Top = 54
          Width = 37
          Height = 13
          Caption = 'Numero'
        end
        object lbl5: TLabel
          Left = 281
          Top = 8
          Width = 28
          Height = 13
          Caption = 'Idade'
        end
        object lbl6: TLabel
          Left = 336
          Top = 8
          Width = 165
          Height = 13
          Caption = 'Contatos(Usar '#39','#39' como separador)'
        end
        object lbl7: TLabel
          Left = 8
          Top = 100
          Width = 28
          Height = 13
          Caption = 'Bairro'
        end
        object lbl8: TLabel
          Left = 152
          Top = 100
          Width = 33
          Height = 13
          Caption = 'Cidade'
        end
        object lbl9: TLabel
          Left = 322
          Top = 100
          Width = 75
          Height = 13
          Caption = 'Dt. Ult. Compra'
        end
        object lbl10: TLabel
          Left = 404
          Top = 100
          Width = 80
          Height = 13
          Caption = 'Valor Ult Compra'
        end
        object edtNome: TEdit
          Left = 8
          Top = 27
          Width = 267
          Height = 21
          TabOrder = 0
          Text = 'Paulo Andr'#233
        end
        object edtIdade: TEdit
          Left = 281
          Top = 27
          Width = 49
          Height = 21
          NumbersOnly = True
          TabOrder = 1
          Text = '40'
        end
        object edtContatos: TEdit
          Left = 336
          Top = 27
          Width = 165
          Height = 21
          TabOrder = 2
          Text = 'Maria, Francisco, Tatiana'
        end
        object chkAtivo: TCheckBox
          Left = 8
          Top = 146
          Width = 97
          Height = 17
          Caption = 'Ativo'
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
        object edtLogradouto: TEdit
          Left = 8
          Top = 73
          Width = 422
          Height = 21
          TabOrder = 4
          Text = 'Rua Capit'#227'o Santos'
        end
        object edtNumero: TEdit
          Left = 436
          Top = 73
          Width = 65
          Height = 21
          TabOrder = 5
          Text = '382'
        end
        object edtBairro: TEdit
          Left = 8
          Top = 119
          Width = 138
          Height = 21
          TabOrder = 6
          Text = 'Messejana'
        end
        object edtCidade: TEdit
          Left = 152
          Top = 119
          Width = 164
          Height = 21
          TabOrder = 7
          Text = 'Fortaleza'
        end
        object medtDataUltimaCompra: TMaskEdit
          Left = 322
          Top = 119
          Width = 78
          Height = 21
          TabOrder = 8
          Text = '15/01/2021'
        end
        object medtValorUltimaCompra: TMaskEdit
          Left = 405
          Top = 119
          Width = 96
          Height = 21
          Alignment = taRightJustify
          TabOrder = 9
          Text = '256,21'
        end
      end
      object btn2: TButton
        Left = 440
        Top = 370
        Width = 75
        Height = 25
        Caption = 'Converter'
        TabOrder = 1
        OnClick = btn2Click
      end
      object mmoJSON: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 202
        Width = 512
        Height = 162
        Align = alTop
        TabOrder = 2
      end
    end
    object tsMultThread: TTabSheet
      Caption = 'MultThread'
      ImageIndex = 2
      object mmoThred: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 512
        Height = 363
        Align = alTop
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object btn3: TButton
        Left = 400
        Top = 372
        Width = 115
        Height = 25
        Caption = 'Criar Threads'
        TabOrder = 1
        OnClick = btn3Click
      end
    end
  end
end
