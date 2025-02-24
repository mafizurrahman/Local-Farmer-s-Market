<?php
// Include your database connection code
include("../Includes/db.php");

// Start the session
session_start();

if (isset($_POST['login'])) {
    $phonenumber = mysqli_real_escape_string($con, $_POST['phonenumber']);
    $password = mysqli_real_escape_string($con, $_POST['password']);

    // ... (rest of your authentication code)

    if ($count_rows == 1) {
        // Authentication successful, set the session variable
        $_SESSION['phonenumber'] = $phonenumber;
    } else {
        echo "<script>alert('Please Enter Valid Details');</script>";
        echo "<script>window.open('FarmerLogin.php','_self')</script>";
    }
}

// Check if the farmer is authenticated and has a session
if (isset($_SESSION['phonenumber'])) {
    // The farmer is authenticated, so retrieve and display visitor information

    // SQL query to retrieve visitor information based on the authenticated farmer's phone number
    $auth_phonenumber = $_SESSION['phonenumber'];
    $query = "SELECT v.vname, v.reason, v.noofvisitors, v.visitorinformation
              FROM visitor v
              INNER JOIN farmerregistration f ON v.phone = f.farmer_phone
              WHERE f.farmer_phone = '$auth_phonenumber'";

    $run_query = mysqli_query($con, $query);

    if ($run_query) {
        // Display the visitor information
        echo '<h2>Your Farm Visitor Information</h2>';
        echo '<table border="1">
                <tr>
                    <th>Name</th>
                    <th>Reason</th>
                    <th>Total Visitors</th>
                    <th>Information</th>
                </tr>';

        while ($row = mysqli_fetch_array($run_query)) {
            echo '<tr>';
            echo '<td>' . $row['vname'] . '</td>';
            echo '<td>' . $row['reason'] . '</td>';
            echo '<td>' . $row['noofvisitors'] . '</td>';
            echo '<td>' . $row['visitorinformation'] . '</td>';
            echo '</tr>';
        }

        echo '</table>';
    } else {
        echo 'Error: ' . mysqli_error($con);
    }
}
?>

<!-- Continue with the rest of your HTML code here -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Farm Visitor Information</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }
        h2 {
            text-align: center;
            margin-top: 20px;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #333;
            color: #fff;
        }
    </style>
</head>