program TesteCM;

uses
  Vcl.Forms,
  frmPrincipal in 'frmPrincipal.pas' {frmTesteCM};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmTesteCM, frmTesteCM);
  Application.Run;
end.
