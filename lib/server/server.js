const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const app = express();
const port = 5000;

// Middleware
app.use(cors());
app.use(express.json()); // To parse JSON request bodies

// MongoDB Connection URL
const mongoURI = 'mongodb://localhost:27017/medical_records1'; // Change this if your MongoDB URL is different

// Connect to MongoDB
mongoose.connect(mongoURI, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => {
    console.log("Connected to MongoDB");
  })
  .catch((err) => {
    console.error("MongoDB connection error:", err);
  });

// Define the patient schema and model
const patientSchema = new mongoose.Schema({
  name: String,
  age: Number,
  bloodGroup: String,
  allergies: String,
  symptoms: [String],  // Array of symptoms
});

const Patient = mongoose.model('Patient', patientSchema);

// API endpoint to fetch the first patient's medical record
app.get('/api/medical-card', async (req, res) => {
  try {
    const patient = await Patient.findOne(); // Fetching the first patient
    if (patient) {
      const response = {
        name: patient.name,
        age: patient.age,
        bloodGroup: patient.bloodGroup,
        allergies: patient.allergies,
        symptoms: patient.symptoms || 'No symptoms recorded',  // Handle undefined symptoms
      };
      res.json(response); // Send the patient data as JSON
    } else {
      res.status(404).json({ message: 'Patient not found' });
    }
  } catch (error) {
    console.error('Error fetching patient data:', error);
    res.status(500).json({ message: 'Server error' });
  }
});

// Start the server
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
