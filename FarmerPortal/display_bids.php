<?php
// Include your database connection code
include("../Includes/db.php");

// Query to fetch data from the 'bids' table that matches farmer_phone
$query = "SELECT b.bid_id, b.product_id, b.bid_amount, b.farmer_phone, b.buyer_address
          FROM bids AS b
          JOIN farmerregistration AS f ON b.farmer_phone = f.farmer_phone";
$result = mysqli_query($con, $query);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Bids Display</title>
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
        <h1>Your Product Bid Details</h1>
        <table>
            <tr>
                <th>Bid ID</th>
                <th>Your Product ID</th>
                <th>Bid Amount</th>
                <th>Your Phone</th>
                <th>Buyer Information</th>
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
                echo "<tr><td colspan='5'>No records found in the 'bids' table.</td></tr>";
            }

            // Close the database connection
            mysqli_close($con);
            ?>
        </table>
    </div>
</body>
</html>
