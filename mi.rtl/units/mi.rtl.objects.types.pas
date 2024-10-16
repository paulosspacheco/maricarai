unit mi.rtl.objects.types;
{:< - A Unit **@name** implementa a classe **TObjectsTypes** .

    - **NOTAS**
      - Esta unit foi testada nas plataformas: win32, win64 e linux.

    - **VERSÃO**
      - Alpha - 1.0.0

    - **CÓDIGO FONTE**:
      - @html(<a href="../units/mi.rtl.objects.types.pas">mi.rtl.objects.types.pas</a>)

    - **HISTÓRICO**
      - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
        - **17/11/2021** 20:30 a 22:49 - Criada a classe **TObjectsTypes**. Falta conclui...
        - **18/11/2021** 09:05         -  Concluir a classe **TObjectsTypes**.
        - **15/12/2021** 15:00 a 15:15 - Revisar a documentação da unidade.
  }

{$IFDEF FPC}
  {$MODE Delphi} {$H+}
{$ENDIF}


interface

uses
  Classes, SysUtils,
  mi.rtl.files;

  Type
  {: - A classe **@name** contém os tipos gerais usados na classe **TObjectss** e seus descendentes.
  }
  TObjectsTypes = class(TFiles)

      {$REGION 'Callbacks'}
         type TCallbackFun = CodePointer;
         type TCallbackProc = CodePointer;
         type TCallbackFunParam = CodePointer;
         type TCallbackFunBool = CodePointer;
         type TCallbackFunBoolParam = CodePointer;
         type TCallbackProcParam = CodePointer;
      {$ENDREGION}

      {$REGION 'HELPER ROUTINES FOR CALLING '}
        {$ifdef cpui8086}
          type VoidLocal = function(_BP: Word): pointer;
          type PointerLocal = function(_BP: Word; Param1: pointer): pointer;
          type VoidMethodLocal = function(_BP: Word): pointer;
          type PointerMethodLocal = function(_BP: Word; Param1: pointer): pointer;
        {$else cpui8086}
          type VoidLocal = function(_EBP: Pointer): pointer;
          type PointerLocal = function(_EBP: Pointer; Param1: pointer): pointer;
          type VoidMethodLocal = function(_EBP: Pointer): pointer;
          type PointerMethodLocal = function(_EBP: Pointer; Param1: pointer): pointer;
        {$endif cpui8086}

        type Voidconstructor = function(VMT: pointer; Obj: pointer): pointer;
        type Pointerconstructor = function(VMT: pointer; Obj: pointer; Param1: pointer): pointer;
        type VoidMethod = function(Obj: pointer): pointer;
        type PointerMethod = function(Obj: pointer; Param1: pointer): pointer;
      {$ENDREGION }

      type TByteArray = TArrayByte;  //:< Usado para acessar a memória.
      type PByteArray = ^TByteArray; //:< Usado para acessar a memória. Byte array pointer

      type TPointerArray = TArrayPtr;  //:< Usado para acessar a memória. Pointer array
      type PPointerArray = ^TPointerArray; //:< Usado para acessar a memória. Pointer array ptr.

           {:- DOS FILENAME String}
      type FNameStr = string;

           {: - DOS ASCIIZ FILENAME
           }
  //    type AsciiZ = Array [0..255] Of AnsiChar;

      type Sw_Word    = LongWord;
      type Sw_Integer = LongInt;

           {: - Stream record ptr }
      type PStreamRec = ^TStreamRec;

           {: - TStreamRec Record - STREAM Class Record
           }
           TStreamRec = Record
                           ObjType: Sw_Word; //:< Class type id
                           //VmtLink: class; //:< Delphi3/FPC like VMT
                           Load : Pointer;   //:< Class load code
                           Store: Pointer;   //:< Class store code
                           Next : PStreamRec;//:< Next stream record
                        end;

      type TItemList = TArrayPtr;
      type PItemList = ^TItemList;

           {: - Internal Class }
      type DummyClass = Class
                           Public Data: Record END; //:< - Helps size VMT link
                        end;

      type TStrIndexRec = Record Key, Count, Offset: Word; END;
      type TStrIndex = Array [0..9999] Of TStrIndexRec;
      type PStrIndex = ^TStrIndex;

      type TLast_Mode_Read_Write = (En_Last_Mode_Null,
                                   En_Last_Mode_Read,
                                   En_Last_Mode_Write,
                                   En_Last_Mode_Flush);


           {: - procedure POINTER DEFINED
           }
      type ProcPtr = procedure (Item: Pointer; _EBP: Sw_Word);


      type TypeData  = Record dia:byte;mes:Byte;ano : byte; End;
      type PTypeData = ^TypeData;

       {: Esse tipo é usado pelo interpretar o tipo TDateTime}
     public Type TMask = ( Mask_yy_mm_dd,   //00
                           Mask_yyyy_mm_dd, //01
                           Mask_dd_mm_yy,   //02
                           Mask_dd_mm_yyyy, //03
//                           Mask_mm_yy,      //04
                           Mask_dd_mm_yyyy_hh_nn, //04
                           Mask_mm_yyyy,    //05
                           Mask_dd_mm_yy_hh_nn_ss,   //06
                           Mask_dd_mm_yy_hh_nn,      //07
                           Mask_dd_mm_yyyy_hh_nn_ss, //08
                           Mask_hh_nn ,              //09
                           Mask_hh_nn_ss,            //10
                           Mask_hh_nn_ss_zzz,        //11
                           Mask_Extenco,             //12
                           Mask_Invalid              //13
                         );


     {: - O tipo enumerado @name controla as ações caso o sistema fique ocioso
     }
      Type TOkProcessingTime_Action = (OkProcessingTime_Action_Abort,OkProcessingTime_Action_Password);


  end;

implementation

end.

