        
        public function MessageBox(const aMsg: AnsiString;
                                   DlgType: TMsgDlgType;
                                   Buttons: TMsgDlgButtons): TModalResult;       
        public function MessageBox(Msg: AnsiString;
                                   DlgType: TMsgDlgType;
                                   Buttons: TMsgDlgButtons;
                                   ButtonDefault: TMsgDlgBtn):TModalResult ;Overload;       
        public function MessageBox(aPSItem : TMI_MsgBoxTypes.PSItem;
                                   DlgType: TMsgDlgType;
                                   Buttons: TMsgDlgButtons;
                                   ButtonDefault: TMsgDlgBtn):TModalResult ;Overload;
        public function MessageBox(aTitle : AnsiString;
                                   Msg: AnsiString;
                                   DlgType: TMsgDlgType;
                                   Buttons: TMsgDlgButtons;
                                   ButtonDefault: TMsgDlgBtn):TModalResult ;Overload;
       


        Public function InputBox(const
                                  aTitle,
                                  aLabel: AnsiString;
                                  var
                                    Buff; {:< uffer da variável para ler.}
                                  Template: AnsiString
                               ): TModalResult;
        Public function InputPassword(const aTitle:AnsiString;var aPassword : AnsiString): TModalResult;
