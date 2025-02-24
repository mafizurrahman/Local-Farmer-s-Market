<!DOCTYPE html>
<html>
<head>
    <title>Image Analysis</title>
</head>
<body>
    <h1>Image Analysis</h1>
    
    <input type="file" id="imageFile" accept="image/*">
    <button onclick="analyzeImage()">Analyze Image</button>

    <div id="results"></div>

    <script>
        async function analyzeImage() {
            const imageFile = document.getElementById('imageFile').files[0];
            const resultsElement = document.getElementById('results');

            if (imageFile) {
                const formData = new FormData();
                formData.append('image', imageFile);

                try {
                    const response = await fetch('/analyze-image.php', {
                        method: 'POST',
                        body: formData,
                    });

                    const data = await response.json();

                    // Display the analysis results
                    resultsElement.innerHTML = JSON.stringify(data, null, 2);
                } catch (error) {
                    console.error('Error analyzing the image:', error);
                }
            }
        }
    </script>
</body>
</html>
