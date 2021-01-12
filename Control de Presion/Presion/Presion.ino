int LED=13;/*declaramos los puertos de LED a usar*/
int LED1=9;
int LED2=3;
int x=2;
int lectura;/*declaramos nuestras variables*/
void setup() {
pinMode(LED, OUTPUT);/*declaramos los LED como salida*/
pinMode(LED1,OUTPUT);
Serial.begin(9600);/*Frecuencia con la que trabajan*/
}
void loop() {
lectura = analogRead(0); /*Usamos una entrada analogica para nuestro POT*/
Serial.print(lectura); /*Mandamos a imprimir nuestra variable de lectura*/
delay(500);/*usamos un tiempo de lectura de 500 milisegundos*/
if(lectura<950 && x==2)/*Declaramos una condicionante*/
{
  digitalWrite(LED,LOW);/*Proceso de encendido y apagado del primer LED*/
  digitalWrite(9,HIGH);/*Proceso de parpadeo del segundo LED*/
delay (500);
   digitalWrite(9,LOW);
   delay (500);
    analogWrite(3, 250);    /* Enciende el tercer LED*/
    }
if(lectura>950)/*Condicionante por si el nivel es mayor a 950, usando una variable donde dejamos un rango*/
  {
    digitalWrite(LED,HIGH);
    digitalWrite(9,HIGH);
    analogWrite(3, 255);
    x=1;
    }
 if(lectura<500 && x==1)/*Tercer condiconante para cuando el contenedor se vacia al 59% o menos*/
 {
  digitalWrite(LED,LOW);
  digitalWrite(9,HIGH);/*Parpadeo del segundo LED, se activa*/
delay (300);
   digitalWrite(9,LOW);
   delay (300);
   x=0; 
 }
 if (lectura>510 && x==0)/*Condicionante para cuando volvemos a subir a 100%*/
 {
  digitalWrite(LED,LOW);
  digitalWrite(9,HIGH); /*Parpadeo del segundo LED*/
delay (100);
   digitalWrite(9,LOW);
   delay (100);
   analogWrite(3, 100);    /* Enciende el tercer LED*/
 }
}
