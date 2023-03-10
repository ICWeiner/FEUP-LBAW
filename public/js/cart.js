function addToCart(id,quant){
    sendAjaxRequest('put','/api/cart/' + id  ,{quantity: quant},productAddedHandler)
}

function updateCartProduct(id){
    quant= document.querySelector('#quantity_'+id).value;
    sendAjaxRequest('post','/api/cart/' + id  ,{quantity: quant},cartUpdatedHandler)
}

function addToWishlist(id,quant){
  sendAjaxRequest('put','/api/wishlist/' + id  ,null,wishlistUpdatedHandler)
}

function productAddedHandler(){
    let item = JSON.parse(this.responseText);

    if(item.operation == 'login'){
      document.getElementById('cart_login_'+item.id).classList.toggle("show");   
    }else{
      document.getElementById('cartAdded_'+item.id).classList.toggle("show");  
    }
  }

function cartUpdatedHandler() {
    let item = JSON.parse(this.responseText);
    let element = document.querySelector('#cartTotal').innerHTML = item.total + "$";

    if (item.new_quantity == 0){
      console.log("hihi")
      document.querySelector('#CartItem_'+item.id).outerHTML = ""
    }
  }

function wishlistUpdatedHandler() {
    let item = JSON.parse(this.responseText);

    if  (window.location.href.includes("wishlist")){
      document.querySelector('#product_'+item.id).outerHTML = "";
    }

    if (item.operation == 'login'){
      document.getElementById('wish_login_'+item.id).classList.toggle("show");   
    }else if(item.operation == 'add'){
      document.getElementById('watchMSG_'+item.id).classList.toggle("show");
    }else{
      document.getElementById('unwatchMSG_'+item.id).classList.toggle("show");
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
 
  

