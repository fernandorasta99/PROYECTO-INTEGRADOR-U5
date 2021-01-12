VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Begin VB.Form Form1 
   BackColor       =   &H8000000A&
   Caption         =   "Form1"
   ClientHeight    =   5490
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   6810
   LinkTopic       =   "Form1"
   ScaleHeight     =   5490
   ScaleWidth      =   6810
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command2 
      BackColor       =   &H8000000A&
      Caption         =   "INICIO"
      Height          =   495
      Left            =   2760
      TabIndex        =   8
      Top             =   2400
      Width           =   1095
   End
   Begin VB.TextBox Text4 
      Alignment       =   2  'Center
      BackColor       =   &H8000000A&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   405
      Left            =   3840
      TabIndex        =   7
      Text            =   "3"
      Top             =   1320
      Width           =   615
   End
   Begin VB.TextBox Text3 
      Alignment       =   2  'Center
      BackColor       =   &H8000000A&
      Height          =   285
      Left            =   6840
      TabIndex        =   5
      Text            =   "0"
      Top             =   5490
      Width           =   975
   End
   Begin VB.CommandButton Command1 
      BackColor       =   &H8000000A&
      Caption         =   "CLS"
      Height          =   255
      Left            =   6840
      TabIndex        =   4
      Top             =   5520
      Width           =   1095
   End
   Begin MSCommLib.MSComm MSComm1 
      Left            =   5280
      Top             =   3480
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      CommPort        =   7
      DTREnable       =   -1  'True
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Left            =   6000
      Top             =   3600
   End
   Begin VB.TextBox Text2 
      Alignment       =   2  'Center
      BackColor       =   &H8000000A&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   390
      Left            =   120
      TabIndex        =   1
      Text            =   "0"
      Top             =   120
      Width           =   1095
   End
   Begin VB.TextBox Text1 
      Alignment       =   2  'Center
      BackColor       =   &H8000000A&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   420
      Left            =   6840
      TabIndex        =   0
      Text            =   "0"
      Top             =   5235
      Width           =   1095
   End
   Begin VB.Label Label3 
      BackColor       =   &H8000000A&
      Caption         =   "PUERTO ARDUINO:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   1920
      TabIndex        =   6
      Top             =   1200
      Width           =   1215
   End
   Begin VB.Shape Shape1 
      BackColor       =   &H00C0C000&
      BackStyle       =   1  'Opaque
      Height          =   15
      Left            =   120
      Top             =   4800
      Width           =   1095
   End
   Begin VB.Label Label2 
      BackColor       =   &H8000000A&
      Caption         =   "NIVEL DEL TANQUE"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   1560
      TabIndex        =   3
      Top             =   120
      Width           =   3015
   End
   Begin VB.Label Label1 
      BackColor       =   &H8000000A&
      Caption         =   "VALOR DE ENTRADA"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   135
      Left            =   6840
      TabIndex        =   2
      Top             =   5520
      Width           =   2295
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Command1_Click()
Cls
End Sub
Private Sub Form_Load()
Timer1.Enabled = False
End Sub

Private Sub Command2_Click()
Timer1.Interval = 100
MSComm1.CommPort = Text4.Text 'Ajustar al puerto real de su arduino en su PC
MSComm1.Settings = "9600,n,8,1" 'Velocidad, Paridad, Bits por Caracter, Bits paro
MSComm1.InputMode = comInputModeText
MSComm1.PortOpen = True 'abre el puerto de comunicacion
'
Timer1.Enabled = True
End Sub

Private Sub Timer1_Timer()
Dim valor As Integer  'declaramos nuestras variables
Dim porcentaje As Single
Dim barra1 As Integer
Dim datoAnterior As Integer
'Verifica si existen datos en el buffer del puerto
If MSComm1.InBufferCount <> 0 Then
'Si existen datos los retira
valor = MSComm1.Input
datoAnterior = valor

'Calcula el nivel de tensión que obtuvo el ADC
porcentaje = valor / 1023 * 100

'Actualiza la ventana con la información recibida
Text1.Text = valor
Text2.Text = Round(porcentaje, 2)
Text3.Text = Text2.Text
barra1 = valor * 3
'
'Creamos un cuadrado
'    Line (500, 4000)-(1600, barra1), RGB(0, 0, 255), BF
Shape1.Height = barra1
Shape1.Top = 4000 - barra1
End If
 If datoAnterior < valor Then
    Cls
    End If
End Sub

