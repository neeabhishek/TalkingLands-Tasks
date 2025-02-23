const express = require('express');
const app = express();
const port = 5000;

app.get('/talking-lands-task', (req, res) => {
  res.send('Hello, Talking Lands!');
});

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`);
});
