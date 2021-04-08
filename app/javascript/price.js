function price() {
  // htmlのclass: "product-price"取得
  const productPrice  = document.getElementById("product-price");
    productPrice.addEventListener("keyup", () => {
      // 入力値取得
      const productValue = productPrice.value;
      // htmlのclass: "fee"取得
      const feePrice = document.getElementById("fee");
      // 手数料計算
      const feeValue = productValue * 0.1
      // htmlに手数料計算結果代入
      feePrice.innerHTML = `${feeValue}`;
      // htmlのclass: "profit"取得
      const profitPrice = document.getElementById("profit");
      // 利益計算
      const profitValue = productValue - feeValue
      // htmlに利益計算結果代入
      profitPrice.innerHTML = `${profitValue}`;
    });
  }
window.addEventListener('load', price)