<!DOCTYPE html>
<html>
<head>
    <title>List of Farmer for Tour Registration</title>
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

        .farmer-list {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
        }

        .farmer-info {
            background-color: #E5E7E9;
            margin: 10px;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
        }

        button {
            background-color: #3498DB;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        /* Add more styles to make it colorful */
        .farmer-info h3 {
            color: #F39C12;
        }

        .farmer-info p {
            color: #555;
        }
    </style>
</head>
<body>
    <h1>List of Farmers for Live Tour Registration</h1>

    <div class="farmer-list">
        <?php
        include("../Includes/db.php");


        $query = "SELECT * FROM farmerregistration ORDER BY farmer_id DESC LIMIT 10";

        // $query = "SELECT * FROM farmerregistration LIMIT 15"; // Limit to 15 records
        $result = mysqli_query($con, $query);

        if ($result) {
            if (mysqli_num_rows($result) > 0) {
                while ($row = mysqli_fetch_assoc($result)) {
                    echo '<div class="farmer-info">';
                    echo '<h3>Farmer Name: ' . $row["farmer_name"] . '</h3>';
                    echo '<p>Farmer Address: ' . $row["farmer_address"] . '</p>';
                    echo '<p>Farmer Phone: ' . $row["farmer_phone"] . '</p>';
                    
                    // Generate random visiting hours for each farmer
                    $visitingHours = generateRandomVisitingHours();
                    echo '<p>Visiting Hours: ' . $visitingHours . '</p>';
                    
                    echo '<a href="registrationtour.php"><button>Register for this farm</button></a>';
                    echo '</div>';
                }
            } else {
                echo "No records found in the database.";
            }
        } else {
            echo "Error: " . mysqli_error($con);
        }

        mysqli_close($con);
        
        // Function to generate random visiting hours
        function generateRandomVisitingHours() {
            $hours = rand(8, 16); // Assuming visiting hours from 8 AM to 4 PM
            $minutes = rand(0, 59);
            return sprintf("%02d:%02d", $hours, $minutes);
        }
        ?>
    </div>
</body>
</html>
