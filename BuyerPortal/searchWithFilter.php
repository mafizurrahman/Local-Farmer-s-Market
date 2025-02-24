<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
<script>
          function state() {
               var a = document.getElementById('states').value;

               if (a === '31') {
                    var array = ['Andamans', 'Nicobars'];
               } else if (a === '01') {
                var array = ['Houston', 'Dallas', 'Austin', 'San Antonio', 'Fort Worth', 'El Paso', 'Arlington', 'Corpus Christi', 'Plano', 'Laredo', 'Irving', 'Garland', 'Amarillo', 'Grand Prairie', 'McAllen', 'Mesquite', 'Killeen', 'Frisco', 'Brownsville', 'Pasadena'];
            } else if (a === '02') {
                var array = ['New York City', 'Buffalo', 'Rochester', 'Yonkers', 'Syracuse', 'Albany', 'New Rochelle', 'Mount Vernon', 'Schenectady', 'Utica', 'White Plains', 'Hempstead', 'Troy', 'Niagara Falls', 'Binghamton', 'Freeport', 'Valley Stream', 'Long Beach', 'Spring Valley', 'Rome'];
            } else if (a === '04') {
                var array = ['Denver', 'Colorado Springs', 'Aurora', 'Fort Collins', 'Lakewood', 'Thornton', 'Arvada', 'Westminster', 'Pueblo', 'Centennial', 'Boulder', 'Greeley', 'Longmont', 'Loveland', 'Broomfield', 'Grand Junction', 'Castle Rock', 'Commerce City', 'Parker', 'Littleton'];
            } else if (a === '03') {
                var array = ['Miami', 'Tampa', 'Orlando', 'St. Petersburg', 'Jacksonville', 'Hialeah', 'Tallahassee', 'Fort Lauderdale', 'Port St. Lucie', 'Cape Coral', 'Pembroke Pines', 'Hollywood', 'Miramar', 'Gainesville', 'Coral Springs', 'Miami Gardens', 'Clearwater', 'Palm Bay', 'Pompano Beach', 'West Palm Beach'];
            } 
               var string = "";
               for (let i = 0; i < array.length; i++) {
                    string = string + "<option>" + array[i] + "</option>";

               }
               string = "<select nmae = 'lol'>" + string + "</select>"
               document.getElementById('district').innerHTML = string;
          }
     </script>
     <script>
          var a;

          function display() {
               if (a == 0) {
                    document.getElementById("majic").style.visibility = "hidden";
                    document.getElementById("show").style.visibility = "visible";
                    return a = 1;
               } else {
                    document.getElementById("majic").style.visibility = "visible";
                    document.getElementById("show").style.visibility = "hidden";
                    // document.getElementById("show").style. visibility= "hidden";

                    return a = 0;
               }

          }
     </script>
 
<label>State</label>
                <table>
                    <select id="states" onchange="state()" tabindex="1">
                         <option value="0">Select State</option>
                         <option value="01">Texas</option>
                         <option value="02">Newyork</option>
                         <option value="03">Florida</option>
                         <option value="04">Colarado</option>
                    </select>


                    <select name="Select City" id="district">
                         <option>Select City</option>
                    </select>


               </table>

</body>
</html>