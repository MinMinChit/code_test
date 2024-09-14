const express = require("express");
const app = express();
const products_routes = require("./routes/products");

const port = process.env.PORT || 3000;

app.get("/", (req, res) => {
  res.send("Hi I am Min Min Chit");
});

app.use(express.json());
app.use("/api/products", products_routes);

const start = async () => {
  try {
    app.listen(port, () => {
      console.log("Connected port: " + port);
    });
  } catch (e) {
    console.log(e);
  }
};

start();
