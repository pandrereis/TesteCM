unit frmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms,Vcl.StdCtrls, System.Generics.Collections, System.Rtti, System.JSON.Writers, System.JSON.Readers,
  System.JSON, Data.DBXJSONReflect, Vcl.ComCtrls,Vcl.ExtCtrls, Vcl.Mask, System.SyncObjs, Vcl.Dialogs;

type
  TCampo = class(TCustomAttribute)
  strict private
    FNome: string;
    FSerializa: Boolean;
    procedure SetNome(const Value: string);
    procedure SetSerializa(const Value: Boolean);
  public
    property Nome: string read FNome write SetNome;
    property Serializa : Boolean read FSerializa write SetSerializa;
    constructor Create(pNome: string; pSerializa : Boolean = True);
  end;

  TPessoa = class
  strict private
    FAtivo: Boolean;
    FIdade: Integer;
    FNome: string;
    FContatos: TArray<string>;
    FLogradouro: string;
    FValorUltimaCompra: Currency;
    FBairro: string;
    FNumero: string;
    FDataUltimaCompra: TDateTime;
    FCidade: string;
    procedure SetAtivo(const Value: Boolean);
    procedure SetIdade(const Value: Integer);
    procedure SetNome(const Value: string);
    procedure SetContatos(const Value: TArray<string>);
    procedure SetBairro(const Value: string);
    procedure SetCidade(const Value: string);
    procedure SetDataUltimaCompra(const Value: TDateTime);
    procedure SetLogradouro(const Value: string);
    procedure SetNumero(const Value: string);
    procedure SetValorUltimaCompra(const Value: Currency);
  public
    [TCampo('P_NOME')]
    property Nome: string read FNome write SetNome;
    [TCampo('P_IDADE')]
    property Idade: Integer read FIdade write SetIdade;
    [TCampo('P_ATIVO')]
    property Ativo: Boolean read FAtivo write SetAtivo;
    [TCampo('P_CONTATOS')]
    property Contatos : TArray<string> read FContatos write SetContatos;
    [TCampo('P_LOGRADOURO')]
    property Logradouro : string read FLogradouro write SetLogradouro;
    [TCampo('P_NUMERO', False)]
    property Numero : string read FNumero write SetNumero;
    [TCampo('P_BAIRRO')]
    property Bairro : string read FBairro write SetBairro;
    [TCampo('P_CIDADE')]
    property Cidade : string read FCidade write SetCidade;
    [TCampo('P_VALOR_ULTMA_COMPRA')]
    property ValorUltimaCompra : Currency read FValorUltimaCompra write SetValorUltimaCompra;
    [TCampo('P_DATA_ULTMA_COMPRA')]
    property DataUltimaCompra: TDateTime read FDataUltimaCompra write SetDataUltimaCompra;

    constructor Create(pNome : string; pIdade : Integer; pAtivo : Boolean; pContatos : TArray<string>;
                       pLogradouro, pNumero, pBairro, pCidade : string; pValorUiltimaCompra : Currency;
                       pDataUltimaCompra : TDateTime);
  end;

  TItem = class
  private
    FNumero: Integer;
    FNomeThread: string;
    procedure SetNomeThread(const Value: string);
    procedure SetNumero(const Value: Integer);
  public
    property NomeThread : string read FNomeThread write SetNomeThread;
    property Numero : Integer read FNumero write SetNumero;
    constructor Create(pNomeThread : string; pNumero : Integer);
  end;

  TContador = class
  private
    FMemo : TMemo;
    FLista : TObjectList<TItem>;
    FSecaoCritica: TCriticalSection;
    FCount : Integer;
    procedure NotifyItemLista(pSender: TObject; const pItem: TItem; pAction: TCollectionNotification);
    procedure SetLista(const Value: TObjectList<TItem>);
  public
    procedure BeforeDestruction; override;
    procedure Incrementa(pNomeThread : string);
    constructor Create(pMemoThread : TMemo);
    procedure Clear;
    property Lista : TObjectList<TItem> read FLista write SetLista;
  end;

  TConversorJSON = class
  strict private
    class procedure construirJSON(pObject: TObject; var pJSONText: TJsonTextWriter); static;
  public
    class function ToJSON(pObject: TObject): string;
  end;

  TfrmTesteCM = class(TForm)
    pgcTeste: TPageControl;
    tsPesquisaLista: TTabSheet;
    tsConversaoJSON: TTabSheet;
    lbl1: TLabel;
    btn1: TButton;
    edt1: TEdit;
    pnl1: TPanel;
    btn2: TButton;
    mmoJSON: TMemo;
    lbl2: TLabel;
    edtNome: TEdit;
    edtIdade: TEdit;
    edtContatos: TEdit;
    chkAtivo: TCheckBox;
    lbl3: TLabel;
    edtLogradouto: TEdit;
    edtNumero: TEdit;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    edtBairro: TEdit;
    edtCidade: TEdit;
    medtDataUltimaCompra: TMaskEdit;
    medtValorUltimaCompra: TMaskEdit;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    tsMultThread: TTabSheet;
    mmoThred: TMemo;
    btn3: TButton;  procedure btn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edt1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
  private
    FContador : TContador;
    FListaValorInt: TDictionary<Integer, Integer>;
  public
    procedure PesquisaValor(pValor: Integer);
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

var
  frmTesteCM: TfrmTesteCM;

implementation

uses
  System.Threading;

{$R *.dfm}

procedure TfrmTesteCM.AfterConstruction;
var
  valor: Integer;
begin
  inherited;
  Randomize;
  pgcTeste.ActivePage := tsPesquisaLista;
  FContador := TContador.Create(mmoThred);
  FListaValorInt := TDictionary<Integer, Integer>.Create;
  repeat
    valor := Random(100000);
    FListaValorInt.Add(FListaValorInt.Count + 1, valor);
  until FListaValorInt.Count = 50000;
end;

procedure TfrmTesteCM.BeforeDestruction;
begin
  inherited;
  FreeAndNil(FContador);
  FreeAndNil(FListaValorInt);
end;

procedure TfrmTesteCM.btn1Click(Sender: TObject);
begin
  if edt1.Text <> EmptyStr then
    PesquisaValor(StrToInt(edt1.Text));
end;

procedure TfrmTesteCM.btn2Click(Sender: TObject);
var
  pessoa: TPessoa;
begin
  try
    mmoJSON.Clear;
    pessoa := TPessoa
        .Create(
            edtNome.Text,
            StrToIntDef(edtIdade.Text, 0),
            chkAtivo.Checked,
            string(edtContatos.Text).Split([',']),
            edtLogradouto.Text,
            edtNumero.Text,
            edtBairro.Text,
            edtCidade.Text,
            StrToFloatDef(medtValorUltimaCompra.Text, 0),
            StrToDateDef(medtDataUltimaCompra.Text, Date)
        );

    mmoJSON.Text := TConversorJSON.ToJSON(pessoa);
  finally
    FreeAndNil(pessoa);
  end;
end;

procedure TfrmTesteCM.btn3Click(Sender: TObject);
begin
  mmoThred.Clear;
  FContador.Clear;
  TThread.CreateAnonymousThread(
      procedure
      var
        I : Integer;
      begin
        while (FContador.Lista.Count <= 100) do
          TThread.Synchronize(
              TThread.CurrentThread,
              procedure
              begin
                FContador.Incrementa('Thread 1');
                TThread.Sleep(50);
              end);
      end
  ).Start;

  TThread.CreateAnonymousThread(
      procedure
      var
        I : Integer;
      begin
        while (FContador.Lista.Count <= 100) do
          TThread.Synchronize(
              TThread.CurrentThread,
              procedure
              begin
                FContador.Incrementa('Thread 2');
                TThread.Sleep(50);
              end
          )
      end
  ).Start;

  TThread.CreateAnonymousThread(
      procedure
      var
        I : Integer;
      begin
        while (FContador.Lista.Count <= 100) do
          TThread.Synchronize(
              TThread.CurrentThread,
              procedure
              begin
                FContador.Incrementa('Thread 3');
                TThread.Sleep(50);
              end
          );
      end
  ).Start;
end;

procedure TfrmTesteCM.edt1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btn1.Click;
end;

procedure TfrmTesteCM.FormShow(Sender: TObject);
begin
  edt1.SetFocus;
end;

procedure TfrmTesteCM.PesquisaValor(pValor: Integer);
begin
  if FListaValorInt.ContainsValue(pValor) then
    ShowMessage('Valor encontrado.')
  else ShowMessage(Format('Valor %S não encontrado.', [edt1.text]));
end;

{ TPessoa }

constructor TPessoa.Create(pNome: string; pIdade: Integer; pAtivo: Boolean; pContatos: TArray<string>; pLogradouro,
  pNumero, pBairro, pCidade: string; pValorUiltimaCompra: Currency; pDataUltimaCompra: TDateTime);
begin
  FNome               := pNome;
  FIdade              := pIdade;
  FAtivo              := pAtivo;
  FContatos           := pContatos;
  FLogradouro         := pLogradouro;
  FNumero             := pNumero;
  FBairro             := pBairro;
  FCidade             := pCidade;
  FValorUltimaCompra  := pValorUiltimaCompra;
  FDataUltimaCompra   := pDataUltimaCompra;
end;

procedure TPessoa.SetAtivo(const Value: Boolean);
begin
  FAtivo := Value;
end;

procedure TPessoa.SetBairro(const Value: string);
begin
  FBairro := Value;
end;

procedure TPessoa.SetCidade(const Value: string);
begin
  FCidade := Value;
end;

procedure TPessoa.SetContatos(const Value: TArray<string>);
begin
  FContatos := Value;
end;

procedure TPessoa.SetDataUltimaCompra(const Value: TDateTime);
begin
  FDataUltimaCompra := Value;
end;

procedure TPessoa.SetIdade(const Value: Integer);
begin
  FIdade := Value;
end;

procedure TPessoa.SetLogradouro(const Value: string);
begin
  FLogradouro := Value;
end;

procedure TPessoa.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TPessoa.SetNumero(const Value: string);
begin
  FNumero := Value;
end;

procedure TPessoa.SetValorUltimaCompra(const Value: Currency);
begin
  FValorUltimaCompra := Value;
end;

{ TCampo }

constructor TCampo.Create(pNome: string; pSerializa : Boolean);
begin
  FNome := pNome;
  FSerializa := pSerializa;
end;

procedure TCampo.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TCampo.SetSerializa(const Value: Boolean);
begin
  FSerializa := Value;
end;

{ TConversorJSON }

class function TConversorJSON.ToJSON(pObject: TObject): string;
var
  jsonWrite: TJsonTextWriter;
  stringWrite: TStringWriter;
begin
  if not Assigned(pObject) then
    raise Exception.Create('Objeto não instânciado.');

  stringWrite := TStringWriter.Create;
  jsonWrite := TJsonTextWriter.Create(stringWrite);
  try
    Self.construirJSON(pObject, jsonWrite);
    Result := stringWrite.ToString;
  finally
    jsonWrite.Free;
    stringWrite.Free;
  end;
end;

class procedure TConversorJSON.construirJSON(pObject: TObject; var pJSONText: TJsonTextWriter);
var
  contexto: TRttiContext;
  propriedade: TRttiProperty;
  atributo: TCustomAttribute;
  atributoNome: string;
  valor: TValue;
  I : Integer;
begin
  try
    atributoNome := '';
    pJSONText.WriteStartObject;
    for propriedade in contexto.GetType(pObject.ClassType).GetProperties do
    begin
      for atributo in propriedade.GetAttributes do
      begin
        if not TCampo(atributo).Serializa then
          Break;

        valor := propriedade.GetValue(pObject);
        if valor.IsEmpty then
          raise Exception.Create('A propriedade não foi preenchida.');

        atributoNome := TCampo(atributo).Nome;

        if propriedade.PropertyType.TypeKind = tkDynArray then
        begin
          pJSONText.WritePropertyName(atributoNome);
          pJSONText.WriteStartArray;
          for I := 0 to Pred(valor.GetArrayLength) do
            pJSONText.WriteValue(valor.GetArrayElement(I));
          pJSONText.WriteEndArray;
        end
        else if (propriedade.PropertyType.TypeKind = tkFloat) then
        begin
          if valor.AsExtended < 0 then
            Break;

          if propriedade.PropertyType.ToString.ToLower.Equals('tdatetime') then
          begin
            if valor.AsExtended > 0 then
            begin
              pJSONText.WritePropertyName(atributoNome);
              pJSONText.WriteValue(valor.AsExtended);
            end;
          end
          else if propriedade.PropertyType.ToString.ToLower.Equals('currency') then
          begin
            pJSONText.WritePropertyName(atributoNome);
            pJSONText.WriteValue(valor.AsCurrency);
          end
          else
          begin
            pJSONText.WritePropertyName(atributoNome);
            pJSONText.WriteValue(valor);
          end;
        end
        else if (propriedade.PropertyType.TypeKind = tkEnumeration) then
        begin
          pJSONText.WritePropertyName(atributoNome);
          if propriedade.PropertyType.Name.Equals('Boolean') then
            pJSONText.WriteValue(valor.AsBoolean);
        end
        else
        begin
          if not valor.IsEmpty then
          begin
            pJSONText.WritePropertyName(atributoNome);
            pJSONText.WriteValue(valor);
          end;
        end
      end;
    end;
    pJSONText.WriteEndObject;
  finally
    contexto.Free;
  end;
end;

{ TItem }

constructor TItem.Create(pNomeThread: string; pNumero: Integer);
begin
  FNumero := pNumero;
  FNomeThread := pNomeThread;
end;

procedure TItem.SetNomeThread(const Value: string);
begin
  FNomeThread := Value;
end;

procedure TItem.SetNumero(const Value: Integer);
begin
  FNumero := Value;
end;

{ TContador }

procedure TContador.BeforeDestruction;
begin
  inherited;
  FreeAndNil(FLista);
  FreeAndNil(FSecaoCritica);
end;

procedure TContador.Clear;
begin
  FLista.Clear;
  FCount := 0;
end;

constructor TContador.Create(pMemoThread: TMemo);
begin
  FCount := 0;
  FMemo := pMemoThread;
  FLista := TObjectList<TItem>.Create;
  FSecaoCritica := TCriticalSection.Create;
  FLista.OnNotify := NotifyItemLista;
end;

procedure TContador.NotifyItemLista(pSender: TObject; const pItem: TItem;  pAction: TCollectionNotification);
begin
  FMemo.Lines.Add(Format('Gravando registro %S Thread %S.', [FormatFloat('000', pItem.Numero), pItem.NomeThread]));
end;

procedure TContador.SetLista(const Value: TObjectList<TItem>);
begin
  FLista := Value;
end;

procedure TContador.Incrementa(pNomeThread: string);
begin
  FSecaoCritica.Acquire;
  if FCount <= 100 then
  begin
    FLista.Add(TItem.Create(pNomeThread, FCount));
    Inc(FCount);
  end;
  FSecaoCritica.Release;
end;

end.

