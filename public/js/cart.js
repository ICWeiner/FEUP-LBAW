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


    console.log("higi");
    if(item.operation == 'login'){
      document.querySelector('#cartLogin_'+item.id).style.display = 'block';
    }else{
      document.querySelector('#cartAdded_'+item.id).style.display = 'block';
    }
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

function wishlistUpdatedHandler() {
    let item = JSON.parse(this.responseText);

    if  (window.location.href.includes("wishlist")){
      document.querySelector('#product_'+item.id).outerHTML = "";
    }

    let watchMSG = document.querySelector('#watchMSG_'+item.id);
    let unwatchMSG = document.querySelector('#unwatchMSG_'+item.id);
    
    if (item.operation == 'login'){
      let loginMSG = document.querySelector('#watchLogin_'+item.id);
      loginMSG.style.display = 'block';
    }else if(item.operation == 'add'){
      unwatchMSG.style.display = 'none';
      watchMSG.style.display = 'block';
    }else{
      watchMSG.style.display = 'none';
      unwatchMSG.style.display = 'block';
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
  

