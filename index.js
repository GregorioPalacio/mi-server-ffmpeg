const express = require("express");
const { exec } = require("child_process");
const app = express();
const port = process.env.PORT || 3000;

const SECRET = process.env.SECRET || "midocodesecreto";

app.use(express.json());

app.post("/run", (req, res) => {
  const { command, token } = req.body;

  if (token !== SECRET) return res.status(403).send("Unauthorized");
  if (!command) return res.status(400).send("No command provided");

  exec(command, (error, stdout, stderr) => {
    if (error) return res.status(500).send(`Error: ${stderr}`);
    res.send(`Output:\n${stdout}`);
  });
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
