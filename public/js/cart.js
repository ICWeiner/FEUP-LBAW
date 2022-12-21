function addToCart(id,quant){

    sendAjaxRequest('put','/api/cart/' + id  ,{quantity: quant},null)
}

function updateCartProduct(id,quant){

    sendAjaxRequest('post','/api/cart/' + id  ,{quantity: quant},cartUpdatedHandler)
}

function cartUpdatedHandler() {
    let item = JSON.parse(this.responseText);
    let element = document.querySelector('#cartTotal').innerHTML = "Total : " + item.total + "$";

    if (item.new_quantity == 0){
      document.querySelector('#CartItem_'+item.id).outerHTML = ""
    }
    //let input = element.querySelector('input[type=checkbox]');
    //element.checked = item.done == "true";
  }
  

function encodeForAjax(data) {
    if (data == null) return null;
    return Object.keys(data).map(function(k){
      return encodeURIComponent(k) + '=' + encodeURIComponent(data[k])
    }).join('&');
  }
  
  function sendAjaxRequest(method, url, data, handler) {
    let request = new XMLHttpRequest();
  
    request.open(method, url, true);
    request.setRequestHeader('X-CSRF-TOKEN', document.querySelector('meta[name="csrf-token"]').content);
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.addEventListener('load', handler);
    request.send(encodeForAjax(data));
    //alert("Product added to cart");
  }
  

