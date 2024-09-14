const express = require("express");
const router = express.Router();
const {
  getAllProducts,
  addNewProduct,
  deleteProductById,
} = require("../controllers/products");

router.route("/items").get(getAllProducts);
router.route("/items").post(addNewProduct);
router.route("/items/:id").delete(deleteProductById);

module.exports = router;
