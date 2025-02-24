<?php
include("../Includes/db.php");
session_start();
$sessphonenumber = $_SESSION['phonenumber'];
?>




<!DOCTYPE html>
<html>
<head>
    <title>Product Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            padding: 20px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            font-weight: bold;
        }
        input[type="text"],
        input[type="number"],
        textarea,
        input[type="datetime-local"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="file"] {
            width: 100%;
        }
        button {
            background-color: #007bff;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 style="text-align: center; color: #007bff;">Product Details Submission</h1>
        <form action="" method="POST" enctype="multipart/form-data">
            <div class="form-group">
                <label for="product_name">Product Name</label>
                <input type="text" id="product_name" name="product_name" required>
            </div>

            <div class="form-group">
                <label for="farmer_phone">Farmer Phone</label>
                <input type="text" id="farmer_phone" name="farmer_phone" required>
            </div>

            <div class="form-group">
                <label for="product_image">Product Image</label>
                <input type="file" id="product_image" name="product_image" accept="image/*" required>
            </div>

            <div class="form-group">
                <label for="product_description">Product Amount(in KG) and Description</label>
                <textarea id="product_description" name="product_description" rows="4" required></textarea>
            </div>

            <div class="form-group">
                <label for="lowest_bid">Lowest Bid(USD)</label>
                <input type="number" id="lowest_bid" name="lowest_bid" required>
            </div>

            <div class="form-group">
                <label for="bid_ending_time">Bid Ending Time</label>
                <input type="datetime-local" id="bid_ending_time" name="bid_ending_time" required>
            </div>

            <button type="submit" name="insert_pro">Submit</button>
        </form>
    </div>
</body>
</html>





<?php
if (isset($_POST['insert_pro'])) {    // when button is clicked

    // getting the text data from fields
    $product_id = $_POST['product_id'];
    $product_name = $_POST['product_name'];
    $product_image = $_POST['product_image'];
    $product_description = $_POST['product_description'];
    $lowest_bid = $_POST['lowest_bid'];
    $bid_ending_time = $_POST['bid_ending_time'];
    $farmer_phone = $_POST['farmer_phone'];
 

    // getting image
    $product_image = $_FILES['product_image']['name'];
    $product_image_tmp = $_FILES['product_image']['tmp_name'];  // for server

    if (isset($_SESSION['phonenumber'])) {
        move_uploaded_file($product_image_tmp, "../Admin/product_images/$product_image");

        $phone = $_SESSION['phonenumber'];
        $getting_id = "select * from farmerregistration where farmer_phone = $sessphonenumber";
        $run = mysqli_query($con, $getting_id);
        $row = mysqli_fetch_array($run);
        $id = $row['farmer_id'];
        $insert_product = "insert into bid (product_id, product_name, product_description, 
                                product_image, lowest_bid, bid_ending_time, farmer_phone) 
                                values ('$product_id','$product_name','$product_description','$product_image','$lowest_bid','$bid_ending_time', '$farmer_phone')";

        $insert_query = mysqli_query($con, $insert_product);
        echo $insert_product;
        if ($insert_query) {
            echo "<script>alert('Product has been added')</script>";
            echo "<script>window.open('farmerHomepage.php','_self')</script>";
        } else {
            echo "<script>alert('Error Uploading Data Please Check your Connections ')</script>";
        }
    }
}


?>