const pay = () => {
  Payjp.setPublicKey("pk_test_98e480a1c4e8b5362629c187"); // PAY.JPテスト公開鍵
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);
    const card = {
      number: formData.get("order_deliver[card-number]"),
      cvc: formData.get("order_deliver[card-cvc]"),
      exp_month: formData.get("order_deliver[card-exp-month]"),
      exp_year: `20${formData.get("order_deliver[card-exp-year]")}`,
    };

    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden"> `;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }

      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");
 
      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("load", pay);