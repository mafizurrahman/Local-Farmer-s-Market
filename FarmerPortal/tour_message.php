<?php



// Include your database connection code
include("../Includes/db.php");

// Query to fetch data from the 'bids' table that matches farmer_phone
$query = "SELECT *
          FROM visitor 
          JOIN farmerregistration ON visitor.phone = farmerregistration.farmer_phone";
$result = mysqli_query($con, $query);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Visitor Details</title>
    <!-- Add Bootstrap CSS link -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f5f5f5;
        }
        .container {
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            padding: 20px;
        }
        .table {
            background-color: #fff;
        }
        th {
            background-color: #007bff;
            color: #fff;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Your Visitor Details</h1>
        <table class="table table-bordered table-striped">
            <thead class="bg-primary text-white">
                <tr>
                    <th>Name</th>
                    <th>Reason</th>
                    <th>Total Visitors</th>
                    <th>Information</th>
                </tr>
            </thead>
            <tbody>

            <?php
            if (mysqli_num_rows($result) > 0) {
                while ($row = mysqli_fetch_assoc($result)) {
                    echo "<tr>
                        <td>{$row['vname']}</td>
                        <td>{$row['reason']}</td>
                        <td>{$row['noofvisitors']}</td>
                        <td>{$row['visitorinformation']}</td>
                    </tr>";
                }
            } else {
                echo "<tr><td colspan='5'>No records found in the 'bids' table.</td></tr>";
            }

            // Close the database connection
            mysqli_close($con);
            ?>

            </tbody>
        </table>
        <a class="btn btn-primary" href="your_other_page.php">Go Back</a>
    </div>

    <!-- Add Bootstrap JS and jQuery script links (optional) -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
