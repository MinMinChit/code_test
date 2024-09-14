const fs = require("fs");

const readDataFromFile = () => {
  const jsonData = fs.readFileSync("./data/data.json", "utf-8");
  return JSON.parse(jsonData);
};

const writeDataToFile = (data) => {
  fs.writeFileSync("./data/data.json", JSON.stringify(data, null, 2), "utf-8");
};

const getAllProducts = async (req, res) => {
  console.log("Get All Products Api");
  try {
    const data = readDataFromFile();

    console.log(data);
    res.status(200).json(data["products"]);
  } catch (e) {
    console.log("Error message : " + e);
    res.status(500).json({
      message: e,
    });
  }
};

const addNewProduct = async (req, res) => {
  console.log("Add New Products Api");
  try {
    const newItem = req.body;

    if (!newItem.name || !newItem.price) {
      return res
        .status(400)
        .json({ message: "Item name and price are required" });
    }

    const items = readDataFromFile();

    const itemLength = items["products"].length ?? 0;
    newItem.id = itemLength == 0 ? 1 : items["products"][itemLength - 1].id + 1;
    items["products"].push(newItem);

    writeDataToFile(items);

    res.status(200).json(newItem);
  } catch (e) {
    console.log("Error message : " + e);
    res.status(500).json({
      message: e,
    });
  }
};

const deleteProductById = async (req, res) => {
  console.log("Delete Products Api");
  try {
    const { id } = req.params;
    if (!id) {
      return res.status(400).json({ message: "Invalid ID." });
    }
    const items = readDataFromFile();

    const leftItems = items["products"].filter((product) => {
      console.log(product.id != id);
      return product.id != id;
    });

    console.log(leftItems);

    if (leftItems.length === items["products"].length) {
      return res
        .status(404)
        .json({ message: `Product with ID ${id} not found` });
    }

    writeDataToFile({
      products: leftItems,
    });

    res.status(200).json({ message: `Product with ID ${id} deleted` });
  } catch (e) {
    console.log("Error message : " + e);
    res.status(500).json({
      message: e,
    });
  }
};

module.exports = { getAllProducts, addNewProduct, deleteProductById };
