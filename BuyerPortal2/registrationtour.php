<?php
include("../Includes/db.php");

// Initialize variables to store user input
$vname = $reason = $visitorinformation = $noofvisitors = $phone = "";

// Check if the form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Retrieve user inputs
    $vname = mysqli_real_escape_string($con, $_POST["vname"]);
    $reason = mysqli_real_escape_string($con, $_POST["reason"]);
    $visitorinformation = mysqli_real_escape_string($con, $_POST["visitorinformation"]);
    $noofvisitors = mysqli_real_escape_string($con, $_POST["noofvisitors"]);
    $phone = mysqli_real_escape_string($con, $_POST["phone"]); // Added phone field

    // Insert the data into the 'visitor' table
    $insertQuery = "INSERT INTO visitor (vname, reason, visitorinformation, noofvisitors, phone) VALUES ('$vname', '$reason', '$visitorinformation', '$noofvisitors', '$phone')";
    $insertResult = mysqli_query($con, $insertQuery);

    if ($insertResult) {
        // Insertion successful, you can redirect or show a success message
        header("Location: tour.php"); // Redirect to a success page
        exit();
    } else {
        // Insertion failed, handle the error as needed
        echo "Error: " . mysqli_error($con);
    }
}

mysqli_close($con);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Farm Tour Registration</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        h1 {
            background-color: #4CAF50;
            color: #fff;
            text-align: center;
            padding: 20px;
        }

        .registration-form {
            background-color: #E5E7E9;
            margin: 10px;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
            margin: 0 auto;
        }

        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            box-sizing: border-box;
            border-radius: 5px;
        }

        button {
            background-color: #3498DB;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <h1>Farm Tour Registration</h1>

    <div class="registration-form">
        <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
            <label for="vname">Visitor Name:</label>
            <input type="text" id="vname" name="vname" required><br>

            <label for="reason">Reason of Visit:</label>
            <input type="text" id="reason" name="reason" required><br>

            <label for="visitorinformation">Visitor Information:</label>
            <input type="text" id="visitorinformation" name="visitorinformation" required><br>

            <label for="noofvisitors">Number of Visitors:</label>
            <input type="number" id="noofvisitors" name="noofvisitors" required><br>
            
            <label for="phone">Farmer's Phone:</label>
            <input type="text" id="phone" name="phone" required><br>

            <button type="submit">Register</button>
        </form>
    </div>
</body>
</html>
