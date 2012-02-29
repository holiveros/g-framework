unit TestgCore;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit
  being tested.

}

interface

uses
  TestFramework, gCore;

type
  // Test methods for class TgBase

  // <summary>TgString5 This is a wrapper for a String that will limit all incoming
  // string assignments to 5 characters
  // </summary>
  TgString5 = record
  strict private
    FValue: String;
  public
    function GetValue: String;
    procedure SetValue(const AValue: String);
    class operator implicit(AValue: Variant): TgString5; overload;
    class operator Implicit(AValue: TgString5): Variant; overload;
    property Value: String read GetValue write SetValue;
  end;

  /// <summary>TPhoneString Automaticly formats all assigned strings to a proper
  /// phone number format
  /// </summary>
  TPhoneString = record
  strict private
    FValue: String;
  public
    function FormatPhone(AValue : String): String;
    function GetValue: String;
    procedure SetValue(const AValue: String);
    class operator Implicit(AValue: TPhoneString): Variant; overload;
    class operator Implicit(AValue: Variant): TPhoneString; overload;
    property Value: String read GetValue write SetValue;
  end;

  TBase2 = Class(TgBase)
  strict private
    FIntegerProperty: Integer;
  published
    [DefaultValue(2)]
    property IntegerProperty: Integer read FIntegerProperty write FIntegerProperty;
  End;

  TBase = class(TgBase)
  strict private
    FBooleanProperty: Boolean;
    FDateProperty: TDate;
    FDateTimeProperty: TDateTime;
    FIntegerProperty: Integer;
    FManuallyConstructedObjectProperty: TBase;
    FObjectProperty: TBase2;
    FPhone: TPhoneString;
    FString5: TgString5;
    FStringProperty: String;
    FUnconstructedObjectProperty: TgBase;
    FUnreadableIntegerProperty: Integer;
    FUnwriteableIntegerProperty: Integer;
    function GetManuallyConstructedObjectProperty: TBase;
  public
    destructor Destroy; override;
  published
    procedure SetUnwriteableIntegerProperty;
    property BooleanProperty: Boolean read FBooleanProperty write FBooleanProperty;
    property DateProperty: TDate read FDateProperty write FDateProperty;
    property DateTimeProperty: TDateTime read FDateTimeProperty write FDateTimeProperty;
    [DefaultValue(5)]
    property IntegerProperty: Integer read FIntegerProperty write FIntegerProperty;
    property ManuallyConstructedObjectProperty: TBase read GetManuallyConstructedObjectProperty;
    property ObjectProperty: TBase2 read FObjectProperty;
    [DefaultValue('Test')]
    [ExcludeFeature([Serializable])]
    property StringProperty: String read FStringProperty write FStringProperty;
    [ExcludeFeature([AutoCreate])]
    property UnconstructedObjectProperty: TgBase read FUnconstructedObjectProperty write FUnconstructedObjectProperty;
    property UnreadableIntegerProperty: Integer write FUnreadableIntegerProperty;
    property UnwriteableIntegerProperty: Integer read FUnwriteableIntegerProperty;
    property String5: TgString5 read FString5 write FString5;
    property Phone: TPhoneString read FPhone write FPhone;
  end;

  TestTBase = class(TTestCase)
  strict private
    Base: TBase;
  public
    procedure PathEndsWithAnObjectProperty;
    procedure PathExtendsBeyondOrdinalProperty;
    procedure PropertyNotReadable;
    procedure PropertyNotWriteable;
    procedure SetPathEndsWithAnObjectProperty;
    procedure SetPathExtendsBeyondOrdinalProperty;
    procedure SetUndeclaredProperty;
    procedure SetUp; override;
    procedure TearDown; override;
    procedure UndeclaredProperty;
  published
    procedure GetValue;
    procedure SetValue;
    procedure Assign;
    procedure DeserializeXML;
    procedure DeserializeJSON;
    procedure SerializeXML;
    procedure SerializeJSON;
    procedure TestCreate;
  end;

  TestTgString5 = class(TTestCase)
  published
    procedure TestLength;
  end;

implementation

Uses
  SysUtils,
  Character
  ;

procedure TestTBase.GetValue;
begin
  // Given a Pathname, return the property value
  CheckEquals('Test', Base['StringProperty'], 'Non-Object Property');
  CheckEquals('Test', Base['ManuallyConstructedObjectProperty.StringProperty'], 'Object Property');
  // If the property doesn't exist, raise an exception
  CheckException(UndeclaredProperty, EgValue);
  // If the path extends beyond an ordinal property, raise an exception
  CheckException(PathExtendsBeyondOrdinalProperty, EgValue);
  // If the path ends with an object property, raise an exception
  CheckException(PathEndsWithAnObjectProperty, EgValue);
  // If the property is not readable, raise an exception
  CheckException(PropertyNotReadable, EgValue);
  // Can we get an Active Value?
  Base.String5 := '123456789';
  CheckEquals('12345', Base['String5'], 'Active Value');
  Base.Phone := '5555555555';
  CheckEquals('(555) 555-5555', Base['Phone'], 'Phone');
  Base.BooleanProperty := True;
  CheckEquals(True, Base['BooleanProperty']);
  CheckEquals('True', Base['BooleanProperty']);
  Base.BooleanProperty := False;
  CheckEquals(False, Base['BooleanProperty']);
  CheckEquals('False', Base['BooleanProperty']);
  Base.DateProperty := StrToDate('1/1/12');
  CheckEquals(StrToDate('1/1/12'), Base['DateProperty'], 'Date as TDate');
  CheckEquals(FloatToStr(StrToDate('1/1/12')), Base['DateProperty'], 'Date as String');
  Base.DateTimeProperty := StrToDateTime('1/1/12 12:34 am');
  CheckEquals(StrToDateTime('1/1/12 12:34 am'), Base['DateTimeProperty'], 'DateTime as TDateTime');
  CheckEquals(FloatToStr(StrToDateTime('1/1/12 12:34 am')), Base['DateTimeProperty'], 'DateTime as String');
end;

procedure TestTBase.PathEndsWithAnObjectProperty;
begin
  Base['ObjectProperty'];
end;

procedure TestTBase.PathExtendsBeyondOrdinalProperty;
begin
  Base['IntegerProperty.ThisShouldNotBeHere'];
end;

procedure TestTBase.PropertyNotReadable;
begin
  Base['UnreadableIntegerProperty'];
end;

procedure TestTBase.PropertyNotWriteable;
begin
  Base['UnwriteableIntegerProperty'] := 5;
end;

procedure TestTBase.SetPathEndsWithAnObjectProperty;
begin
  Base['ObjectProperty'] := 'Test';
end;

procedure TestTBase.SetPathExtendsBeyondOrdinalProperty;
begin
  Base['IntegerProperty.ThisShouldNotBeHere'] := 'Test';
end;

procedure TestTBase.SetUndeclaredProperty;
begin
  Base['ThisPropertyDoesNotExist'] := 'Test';
end;

procedure TestTBase.SetUp;
begin
  Base := TBase.Create;
end;

procedure TestTBase.SetValue;
begin
  // Given a Pathname, set the property value
  Base['StringProperty'] := 'Test2';
  CheckEquals('Test2', Base.StringProperty, 'Non-Object Property');
  Base['ManuallyConstructedObjectProperty.StringProperty'] := 'Test2';
  CheckEquals('Test2', Base.ManuallyConstructedObjectProperty.StringProperty, 'Object Property');
  // If the property doesn't exist, raise an exception
  CheckException(SetUndeclaredProperty, EgValue);
  // If the path extends beyond a non-object property, raise an exception
  CheckException(SetPathExtendsBeyondOrdinalProperty, EgValue);
  // If the path ends with an object property, raise an exception
  CheckException(SetPathEndsWithAnObjectProperty, EgValue);
  // If the property is not writeable, raise an exception
  CheckException(PropertyNotWriteable, EgValue);
  // Call a method
  Base['SetUnwriteableIntegerProperty'] := '';
  CheckEquals(10, Base.UnwriteableIntegerProperty);
  Base['ManuallyConstructedObjectProperty.SetUnwriteableIntegerProperty'] := '';
  CheckEquals(10, Base.ManuallyConstructedObjectProperty.UnwriteableIntegerProperty);
  Base['String5'] := '123456789';
  CheckEquals('12345', Base.String5);
  Base['BooleanProperty'] := True;
  CheckEquals(True, Base.BooleanProperty);
  Base['BooleanProperty'] := False;
  CheckEquals(False, Base.BooleanProperty);
  Base['BooleanProperty'] := 'True';
  CheckEquals(True, Base.BooleanProperty);
  Base['BooleanProperty'] := 'False';
  CheckEquals(False, Base.BooleanProperty);
  Base['DateProperty'] := StrToDate('1/1/12');
  CheckEquals(StrToDate('1/1/12'), Base.DateProperty, 'Date as TDate');
  Base['DateProperty'] := '1/1/12';
  CheckEquals(StrToDate('1/1/12'), Base.DateProperty, 'Date as String');
  Base['DateTimeProperty'] := StrToDateTime('1/1/12 12:34 am');
  CheckEquals(StrToDateTime('1/1/12 12:34 am'), Base.DateTimeProperty, 'DateTime as TDateTime');
  Base['DateTimeProperty'] := '1/1/12 12:34 am';
  CheckEquals(StrToDateTime('1/1/12 12:34 am'), Base.DateTimeProperty, 'DateTime as String');
end;

procedure TestTBase.TearDown;
begin
  FreeAndNil(Base);
end;

procedure TestTBase.Assign;
var
  Target: TBase;
begin
  Target := TBase.Create(Base);
  try
    Base.IntegerProperty := 6;
    Base.StringProperty := 'Hello';
    Base.Phone := '5555555555';
    Target.Assign(Base);
    CheckEquals(6, Target.IntegerProperty);
    CheckNull(Target.Inspect(G.PropertyByName(Target, 'ManuallyConstructedObjectProperty')));
    CheckEquals('Test', Target.StringProperty);
    CheckEquals('(555) 555-5555', Target.Phone);
  finally
    Target.Free;
  end;
end;

procedure TestTBase.DeserializeXML;
var
  XMLString: string;
begin
  XMLString :=
    '<xml>'#13#10 + //0
    '  <Base classname="TestgCore.TBase">'#13#10 + //1
    '    <BooleanProperty>True</BooleanProperty>'#13#10 + //2
    '    <DateProperty>1/1/2012</DateProperty>'#13#10 + //3
    '    <DateTimeProperty>1/1/2012 00:34:00</DateTimeProperty>'#13#10 + //4
    '    <IntegerProperty>5</IntegerProperty>'#13#10 + //5
    '    <ManuallyConstructedObjectProperty classname="TestgCore.TBase">'#13#10 + //6
    '      <BooleanProperty>False</BooleanProperty>'#13#10 + //7
    '      <DateProperty>12/30/1899</DateProperty>'#13#10 + //8
    '      <DateTimeProperty>12/30/1899 00:00:00</DateTimeProperty>'#13#10 + //9
    '      <IntegerProperty>6</IntegerProperty>'#13#10 + //10
    '      <ObjectProperty classname="TestgCore.TBase2">'#13#10 + //11
    '        <IntegerProperty>2</IntegerProperty>'#13#10 + //12
    '      </ObjectProperty>'#13#10 + //13
    '      <String5>98765</String5>'#13#10 + //14
    '      <Phone>(444) 444-4444</Phone>'#13#10 + //15
    '    </ManuallyConstructedObjectProperty>'#13#10 + //16
    '    <ObjectProperty classname="TestgCore.TBase2">'#13#10 + //17
    '      <IntegerProperty>2</IntegerProperty>'#13#10 + //18
    '    </ObjectProperty>'#13#10 + //19
    '    <String5>12345</String5>'#13#10 + //20
    '    <Phone>(555) 555-5555</Phone>'#13#10 + //21
    '  </Base>'#13#10 + //22
    '</xml>'#13#10; //23
  Base.Deserialize(TgSerializerXML, XMLString);
  CheckEquals('12345', Base.String5);
  CheckEquals('(555) 555-5555', Base.Phone);
  CheckEquals(6, Base.ManuallyConstructedObjectProperty.IntegerProperty);
  CheckEquals('98765', Base.ManuallyConstructedObjectProperty.String5);
  CheckEquals('(444) 444-4444', Base.ManuallyConstructedObjectProperty.Phone);
  CheckEquals(True, Base.BooleanProperty);
  CheckEquals(StrToDate('1/1/12'), Base.DateProperty);
  CheckEquals(StrToDateTime('1/1/12 12:34 am'), Base.DateTimeProperty);
end;

procedure TestTBase.DeserializeJSON;
var
  JSONString: string;
begin
  JSONString :=
    '{"ClassName":"TestgCore.TBase","BooleanProperty":"True","DateProperty":"1/'+
    '1/2012","DateTimeProperty":"1/1/2012 00:34:00","IntegerProperty":"5","Manu'+
    'allyConstructedObjectProperty":{"ClassName":"TestgCore.TBase","BooleanProp'+
    'erty":"False","DateProperty":"12/30/1899","DateTimeProperty":"12/30/1899 0'+
    '0:00:00","IntegerProperty":"6","ObjectProperty":{"ClassName":"TestgCore.TB'+
    'ase2","IntegerProperty":"2"},"String5":"98765","Phone":"(444) 444-4444"},"'+
    'ObjectProperty":{"ClassName":"TestgCore.TBase2","IntegerProperty":"2"},"St'+
    'ring5":"12345","Phone":"(555) 555-5555"}';
  Base.Deserialize(TgSerializerJSON, JSONString);
  CheckEquals('12345', Base.String5);
  CheckEquals('(555) 555-5555', Base.Phone);
  CheckEquals(6, Base.ManuallyConstructedObjectProperty.IntegerProperty);
  CheckEquals('98765', Base.ManuallyConstructedObjectProperty.String5);
  CheckEquals('(444) 444-4444', Base.ManuallyConstructedObjectProperty.Phone);
  CheckEquals(True, Base.BooleanProperty);
  CheckEquals(StrToDate('1/1/12'), Base.DateProperty);
  CheckEquals(StrToDateTime('1/1/12 12:34 am'), Base.DateTimeProperty);
end;

procedure TestTBase.SerializeXML;
var
  XMLString: string;
begin
  Base.String5 := '123456789';
  Base.Phone := '5555555555';
  Base.ManuallyConstructedObjectProperty.IntegerProperty := 6;
  Base.ManuallyConstructedObjectProperty.String5 := '987654321';
  Base.ManuallyConstructedObjectProperty.Phone := '4444444444';
  Base.BooleanProperty := True;
  Base.DateProperty := StrToDate('1/1/12');
  Base.DateTimeProperty := StrToDateTime('1/1/12 12:34 am');
  XMLString :=
    '<xml>'#13#10 + //0
    '  <Base classname="TestgCore.TBase">'#13#10 + //1
    '    <BooleanProperty>True</BooleanProperty>'#13#10 + //2
    '    <DateProperty>1/1/2012</DateProperty>'#13#10 + //3
    '    <DateTimeProperty>1/1/2012 00:34:00</DateTimeProperty>'#13#10 + //4
    '    <IntegerProperty>5</IntegerProperty>'#13#10 + //5
    '    <ManuallyConstructedObjectProperty classname="TestgCore.TBase">'#13#10 + //6
    '      <BooleanProperty>False</BooleanProperty>'#13#10 + //7
    '      <DateProperty>12/30/1899</DateProperty>'#13#10 + //8
    '      <DateTimeProperty>12/30/1899 00:00:00</DateTimeProperty>'#13#10 + //9
    '      <IntegerProperty>6</IntegerProperty>'#13#10 + //10
    '      <ObjectProperty classname="TestgCore.TBase2">'#13#10 + //11
    '        <IntegerProperty>2</IntegerProperty>'#13#10 + //12
    '      </ObjectProperty>'#13#10 + //13
    '      <String5>98765</String5>'#13#10 + //14
    '      <Phone>(444) 444-4444</Phone>'#13#10 + //15
    '    </ManuallyConstructedObjectProperty>'#13#10 + //16
    '    <ObjectProperty classname="TestgCore.TBase2">'#13#10 + //17
    '      <IntegerProperty>2</IntegerProperty>'#13#10 + //18
    '    </ObjectProperty>'#13#10 + //19
    '    <String5>12345</String5>'#13#10 + //20
    '    <Phone>(555) 555-5555</Phone>'#13#10 + //21
    '  </Base>'#13#10 + //22
    '</xml>'#13#10; //23
  CheckEquals(XMLString, Base.Serialize(TgSerializerXML));
end;

procedure TestTBase.SerializeJSON;
var
  JSONString: string;
begin
  Base.String5 := '123456789';
  Base.Phone := '5555555555';
  Base.ManuallyConstructedObjectProperty.IntegerProperty := 6;
  Base.ManuallyConstructedObjectProperty.String5 := '987654321';
  Base.ManuallyConstructedObjectProperty.Phone := '4444444444';
  Base.BooleanProperty := True;
  Base.DateProperty := StrToDate('1/1/12');
  Base.DateTimeProperty := StrToDateTime('1/1/12 12:34 am');
  JSONString :=
    '{"ClassName":"TestgCore.TBase","BooleanProperty":"True","DateProperty":"1/'+
    '1/2012","DateTimeProperty":"1/1/2012 00:34:00","IntegerProperty":"5","Manu'+
    'allyConstructedObjectProperty":{"ClassName":"TestgCore.TBase","BooleanProp'+
    'erty":"False","DateProperty":"12/30/1899","DateTimeProperty":"12/30/1899 0'+
    '0:00:00","IntegerProperty":"6","ObjectProperty":{"ClassName":"TestgCore.TB'+
    'ase2","IntegerProperty":"2"},"String5":"98765","Phone":"(444) 444-4444"},"'+
    'ObjectProperty":{"ClassName":"TestgCore.TBase2","IntegerProperty":"2"},"St'+
    'ring5":"12345","Phone":"(555) 555-5555"}';
  CheckEquals(JSONString, Base.Serialize(TgSerializerJSON));
end;

procedure TestTBase.TestCreate;
var
  Base1: TBase;
  Base2: TBase2;
begin
  CheckNull(Base.Owner, 'When a constructor is called without a parameter, its owner should be nil.');
  CheckNotNull(Base.ObjectProperty, 'Object properties should be constructed automatically if the Exclude([AutoCreate]) attribute is not set.');
  CheckNull(Base.UnconstructedObjectProperty, 'Object properties with the Exlude([AutoCreate]) attribute should not be nil.');
  Check(Base=Base.ObjectProperty.Owner, 'The owner of an automatically constructed object property shoud be set to the object that created it.');
  CheckEquals(5, Base.IntegerProperty, 'Default integer values should be set for properties with a DefaultValue attribute.');
  CheckEquals('Test', Base.StringProperty, 'Default string values should be set for properties with a DefaultValue attribute.');
  Base2 := TBase2.Create;
  try
    Base1 := TBase.Create(Base2);
    try
      Check(Base1.ObjectProperty = Base2, 'Object properties should take the value of an existing owner object if one exists.');
    finally
      Base1.Free;
    end;
  finally
    Base2.Free;
  end;
end;

procedure TestTBase.UndeclaredProperty;
begin
  Base['ThisPropertyDoesNotExist'];
end;

destructor TBase.Destroy;
begin
  FreeAndNil(FManuallyConstructedObjectProperty);
  inherited Destroy;
end;

function TBase.GetManuallyConstructedObjectProperty: TBase;
begin
  if Not IsInspecting And Not Assigned(FManuallyConstructedObjectProperty) then
    FManuallyConstructedObjectProperty := TBase.Create(Self);
  Result := FManuallyConstructedObjectProperty;
end;

procedure TBase.SetUnwriteableIntegerProperty;
begin
  FUnwriteableIntegerProperty := 10;
end;

function TgString5.GetValue: String;
begin
  Result := FValue;
end;

procedure TgString5.SetValue(const AValue: String);
begin
  FValue := Copy(AValue, 1, 5);
end;

class operator TgString5.implicit(AValue: Variant): TgString5;
begin
  Result.Value := AValue;
end;

class operator TgString5.Implicit(AValue: TgString5): Variant;
begin
  Result := AValue.Value;
end;

procedure TestTgString5.TestLength;
var
  String5: TgString5;
begin
  String5 := '123456789';
  CheckEquals('12345', String5);
end;

function TPhoneString.FormatPhone(AValue : String): String;
Var
  CurrentCharacter: Char;
Begin
  Result := '';
  for CurrentCharacter in AValue do
  Begin
    if IsNumber(CurrentCharacter) then
      Result := Result + CurrentCharacter;
  End;
  Case Length(Result) Of
    7 :
    Begin
      Insert('(   ) ', Result, 1);
      Insert('-', Result, 10);
    End;
    10 :
    Begin
      Insert('(', Result, 1);
      Insert(') ', Result, 5);
      Insert('-', Result, 10);
    End;
    Else
      Result := AValue;
  End;
End;

function TPhoneString.GetValue: String;
begin
  Result := FValue;
end;

procedure TPhoneString.SetValue(const AValue: String);
begin
  FValue := FormatPhone(AValue);
end;

class operator TPhoneString.Implicit(AValue: TPhoneString): Variant;
begin
  Result := AValue.Value;
end;

class operator TPhoneString.Implicit(AValue: Variant): TPhoneString;
begin
  Result.Value := AValue;
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTBase.Suite);
  RegisterTest(TestTgString5.Suite);
end.






