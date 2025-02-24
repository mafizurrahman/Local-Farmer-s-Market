<!DOCTYPE html>
<html>
<head>
    <title>Product Display</title>
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
        .bid-input {
            width: 60px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Product Details</h1>
        <table>
            <tr>
                <th>Product Image</th>
                <th>Product Name</th>
                <th>Product Description</th>
                <th>Lowest Bid</th>
                <th>Bid Ending Time</th>
                <th>Farmer Phone</th>
                <th>Action</th>
            </tr>

            <?php
            include("../Includes/db.php");

            // Query to fetch data from the 'bid' table
            $query = "SELECT * FROM bid";
            $result = mysqli_query($con, $query);

            if (mysqli_num_rows($result) > 0) {
                while ($row = mysqli_fetch_assoc($result)) {
                    echo "<tr>
                        <td><img src='{$row['product_image']}' alt='{$row['product_name']}' style='width: 100px;'></td>
                        <td>{$row['product_name']}</td>
                        <td>{$row['product_description']}</td>
                        <td>{$row['lowest_bid']}</td>
                        <td>{$row['bid_ending_time']}</td>
                        <td>{$row['farmer_phone']}</td>
                        <td>
                            <form method='post' action=''>
                                <input class='bid-input' type='number' name='bid_amount' placeholder='Bid Amount' min='{$row['lowest_bid']}' required>
                                <input type='text' name='buyer_address' placeholder='Your Contact No and Address' required>
                                <input type='hidden' name='product_id' value='{$row['product_id']}'>
                                <input type='hidden' name='farmer_phone' value='{$row['farmer_phone']}'>
                                <input type='submit' name='submit_bid' value='Place Bid'>
                            </form>
                        </td>
                    </tr>";
                }
            } else {
                echo "<tr><td colspan='7'>No records found in the 'bid' table.</td></tr>";
            }

            mysqli_close($con);
            ?>
        </table>
    </div>
</body>
</html>

<?php
include("../Includes/db.php");

if (isset($_POST['submit_bid'])) {
    $product_id = $_POST['product_id'];
    $bid_amount = $_POST['bid_amount'];
    $farmer_phone = $_POST['farmer_phone'];
    $buyer_address = $_POST['buyer_address'];

    // You should validate and sanitize the input before inserting it into the database

    // Insert the bid into the 'bids' table
    $query = "INSERT INTO bids (product_id, bid_amount, farmer_phone, buyer_address) VALUES ('$product_id', '$bid_amount', '$farmer_phone', '$buyer_address')";
    $result = mysqli_query($con, $query);
    if ($result) {
        echo "<p class='success'>Bid placed successfully.</p>";
    } else {
        echo "<p class='error'>Failed to place the bid.</p>";
    }
}

// ... Rest of your code ...
?>
