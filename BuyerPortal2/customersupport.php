<!DOCTYPE html>
<html>
<head>
    <title>Customer Support</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="#">Online Farmers Market</a>
    </nav>
    <div class="container mt-5">
        <?php
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            echo '<div class="alert alert-success">Thank you, our team will contact you soon.</div>';
        } else {
            echo '
            <h1 class="text-center mb-4">Contact Customer Support</h1>
            <form action="" method="post">
                <div class="form-group">
                    <label for="name">Your Name:</label>
                    <input type="text" id="name" name="name" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="email">Your Email:</label>
                    <input type="email" id="email" name "email" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="message">Message:</label>
                    <textarea id="message" name="message" rows="4" class="form-control" required></textarea>
                </div>

                <div class="form-group">
                    <button type="submit" class="btn btn-success">Submit</button>
                </div>
            </form>';
        }
        ?>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
