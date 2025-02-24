<!DOCTYPE html>
<html>
<head>
    <title>Available Online Farming Courses</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        h1 {
            background-color: #4CAF50;
            color: #fff;
            text-align: center;
            padding: 20px;
            font-size: 36px;
        }

        .course-list {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            padding: 20px;
        }

        .course-card {
            background-color: #fff;
            margin: 20px;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
        }

        h2 {
            color: #4CAF50;
            font-size: 24px;
        }

        p {
            color: #333;
        }

        a {
            color: #4CAF50;
            text-decoration: none;
        }

        .copyright {
            text-align: center;
            padding: 20px;
            color: #555;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <h1>Available Online Farming Courses</h1>
    <div class="course-list">
        <?php
        // Sample farming course data - You should replace this with data from a database
        $farmingCourses = [
            [
                'course_name' => 'Crop Management 101',
                'description' => 'Learn the basics of crop management and cultivation techniques.',
                'length' => '6 weeks',
                'syllabus' => 'Crop_Management_Syllabus.php',
                'class_time' => 'Mondays and Wednesdays, 9:00 AM - 11:00 AM',
            ],
            [
                'course_name' => 'Vegetable Farming Masterclass',
                'description' => 'Master the art of growing a variety of delicious vegetables.',
                'length' => '8 weeks',
                'syllabus' => 'Vegetable_Farming_Syllabus.php',
                'class_time' => 'Tuesdays and Thursdays, 10:00 AM - 12:00 PM',
            ],
            [
                'course_name' => 'Fruit Orchard Care and Maintenance',
                'description' => 'Discover how to care for fruit orchards and ensure healthy fruit production.',
                'length' => '10 weeks',
                'syllabus' => 'Fruit_Orchard_Syllabus.php',
                'class_time' => 'Fridays, 2:00 PM - 4:00 PM',
            ],
            // Add more farming courses as needed
        ];

        // Function to generate a random Zoom meeting link
        function generateRandomZoomLink() {
            $meetingId = rand(1000000000, 9999999999);
            $zoomLink = "https://zoom.us/j/{$meetingId}";
            return $zoomLink;
        }

        // Loop through the farming courses and display them
        foreach ($farmingCourses as $course) {
            echo "<div class='course-card'>";
            echo "<h2>{$course['course_name']}</h2>";
            echo "<p>{$course['description']}</p>";
            echo "<p><strong>Course Length:</strong> {$course['length']}</p>";
            echo "<p><strong>Class Time:</strong> {$course['class_time']}</p>";
            echo "<p><strong>Course Syllabus:</strong> <a href='syllabus.php?course={$course['syllabus']}'>See Syllabus</a></p>";
            echo "<p><strong>Join Class:</strong> <a href='" . generateRandomZoomLink() . "' target='_blank'>Join Zoom Class</a></p>";
            echo "</div>";
        }
        ?>
    </div>

    <div class="copyright">
        &copy; <?php echo date("Y"); ?> Online Farmers Market
    </div>
</body>
</html>
