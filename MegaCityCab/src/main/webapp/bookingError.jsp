<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Error</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        /* ======= General Styles ======= */
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea, #764ba2);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #333;
        }

        /* ======= Error Container ======= */
        .error-container {
            background: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 400px;
            animation: fadeIn 1s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .error-container h2 {
            font-size: 24px;
            font-weight: 600;
            color: #ff4757;
            margin-bottom: 20px;
        }

        .error-container p {
            font-size: 16px;
            color: #555;
            margin-bottom: 20px;
        }

        .error-container a {
            display: inline-block;
            padding: 10px 20px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: 500;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .error-container a:hover {
            transform: translateY(-2px);
            box-shadow: 0px 5px 15px rgba(102, 126, 234, 0.4);
        }

        /* ======= Responsive Design ======= */
        @media (max-width: 480px) {
            .error-container {
                width: 90%;
                padding: 20px;
            }

            .error-container h2 {
                font-size: 20px;
            }

            .error-container p {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>

    <!-- Error Container -->
    <div class="error-container">
        <h2>Something went wrong!</h2>
        <p>We encountered an issue while processing your booking. Please try again later.</p>
        <a href="customerDashboard.jsp">Go Back to Dashboard</a>
    </div>

</body>
</html>