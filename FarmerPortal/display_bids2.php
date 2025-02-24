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
    // The farmer is authenticated, so retrieve and display bidder information

    // SQL query to retrieve bidder information based on the authenticated farmer's phone number
    $auth_phonenumber = $_SESSION['phonenumber'];
    $query = "SELECT b.bid_id, b.product_id, b.bid_amount, b.farmer_phone, b.buyer_address
              FROM bids AS b
              WHERE b.farmer_phone = '$auth_phonenumber'";
    $result = mysqli_query($con, $query);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Your Bidders</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #007bff;
            color: #fff;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        h1 {
            text-align: center;
            color: #007bff;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Your Product Bidders</h1>
        <table>
            <tr>
                <th>Bid ID</th>
                <th>Product ID</th>
                <th>Bid Amount</th>
                <th>Seller Phone</th>
                <th>Buyer Phone & Address</th>
            </tr>

            <?php
            if (mysqli_num_rows($result) > 0) {
                while ($row = mysqli_fetch_assoc($result)) {
                    echo "<tr>
                        <td>{$row['bid_id']}</td>
                        <td>{$row['product_id']}</td>
                        <td>{$row['bid_amount']}</td>
                        <td>{$row['farmer_phone']}</td>
                        <td>{$row['buyer_address']}</td>
                    </tr>";
                }
            } else {
                echo "<tr><td colspan='5'>No bidders found for your products.</td></tr>";
            }

            // Close the database connection
            mysqli_close($con);
            ?>
        </table>
    </div>
</body>
</html>
<?php
} // Close the if(isset($_SESSION['phonenumber'])) condition
?>
